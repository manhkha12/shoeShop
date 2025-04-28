import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoe_store/data/local/app_provider.dart';
import 'package:shoe_store/features/peoduct_detail/bottom_sheet.dart';
import 'package:shoe_store/gen/assets.gen.dart';
import 'package:shoe_store/shared/cubits/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:shoe_store/shared/cubits/add_to_cart_cubit/add_to_cart_state.dart';
import 'package:shoe_store/shared/cubits/product_detail_cubit/product_detail_cubit.dart';
import 'package:shoe_store/shared/cubits/product_detail_cubit/product_detail_state.dart';
import 'package:shoe_store/shared/extensions/extensions.dart';
import 'package:shoe_store/shared/models/product.dart';
import 'package:shoe_store/shared/widgets/app_text.dart';
import 'package:shoe_store/shared/widgets/app_text_icon.dart';
import 'package:shoe_store/shared/widgets/buttons/app_button.dart';

class BottomSheetContent extends StatefulWidget {
  final Product product;
  final VoidCallback? onAddToCartSuccess;
  const BottomSheetContent(
      {super.key, required this.product, this.onAddToCartSuccess});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  String? selectedColor;
  String? selectedSize;
  int quantity = 1;
  String? userId;
  late final AddToCartCubit addToCartCubit;

  void _onQuantityChanged(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });
  }

  @override
  void initState() {
    super.initState();
    addToCartCubit = context.read<AddToCartCubit>();
    // final userId = context.watch<AppProvider>().userId.toString();
    // addToCartCubit.userIdChanged(userId);
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id')?.toString();
    if (userId != null) {
      addToCartCubit.userIdChanged(userId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToCartCubit, AddToCartState>(
      listener: (context, state) {
        print(
            "🎯 Listener - state: isLoading=${state.isLoading}, success=${state.addToCartSuccess}");
        if (state.addToCartSuccess) {
          Navigator.pop(context);
          widget.onAddToCartSuccess?.call();
        }
      },
      child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.productDetail.isEmpty) {
            return Center(child: Text("Không có dữ liệu chi tiết"));
          }

          final detail = state.productDetail.first;
          // Lọc các variants theo màu đã chọn
          final filteredVariants =
              detail.variants.where((v) => v.color == selectedColor).toList();

          // Lấy danh sách size duy nhất cho màu đó
          final sizesForColor =
              filteredVariants.map((v) => v.size).toSet().toList();
          return FractionallySizedBox(
            heightFactor: 0.6,
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: CachedNetworkImage(
                            imageUrl: widget.product.imageUrl ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 76),
                          AppText('đ${widget.product.price}'),
                          const SizedBox(height: 20),
                          AppText('Kho: ${widget.product.stock}'),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                    height: 1, color: context.colors.black.withOpacity(0.4)),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText('Màu sắc'),
                          AppTextIcon('Hướng dẫn chọn size',
                              isReverse: true,
                              icon: Assets.icons.arrowRight.path)
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        children: detail.variants
                            .map((v) => v.color)
                            .toSet()
                            .map((color) => Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, bottom: 8),
                                  child: TextClickButton(
                                    text: color,
                                    isSelected: selectedColor == color,
                                    onTap: () {
                                      setState(() {
                                        selectedColor = color;
                                        selectedSize = null;
                                        // Reset selectedSize nếu muốn
                                      });
                                    },
                                  ),
                                ))
                            .toList(),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: context.colors.black.withOpacity(0.3),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppText('Size'),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Wrap(
                        children: sizesForColor.map((size) {
                          final variant = filteredVariants.firstWhere(
                            (v) => v.size == size,
                            orElse: () => detail.variants.first, //cho đỡ lỗi
                          );

                          final isOutOfStock = variant.stock! <= 0;

                          return Padding(
                            padding: const EdgeInsets.only(right: 8, bottom: 8),
                            child: TextClickButton(
                              text: size,
                              isSelected: selectedSize == size,
                              isDisabled: isOutOfStock,
                              onTap: isOutOfStock
                                  ? null
                                  : () {
                                      setState(() {
                                        selectedSize = size;
                                      });
                                    },
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: context.colors.black.withOpacity(0.3),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: AppText(
                        'Số lượng',
                        fontSize: 14,
                      )),
                      const SizedBox(
                        height: 12,
                      ),
                      QuantityProduct(
                        onQuantityChanged: _onQuantityChanged,
                      ),
                    ],
                  ),
                ),
                BlocBuilder<AddToCartCubit, AddToCartState>(
                    builder: (context, state) {
                  final variant = detail.variants.firstWhere(
                    (v) => v.color == selectedColor && v.size == selectedSize,
                    orElse: () => detail.variants.first,
                  );
                  String variantId = variant.variantId.toString();

                  addToCartCubit.variantIdChanged(variantId);
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: AppButton(
                        primaryColor: context.colors.easyColor,
                        label: 'Thêm vào giỏ hàng',
                        onPressed: (selectedColor != null &&
                                selectedSize != null &&
                                quantity > 0)
                            ? () async {
                                addToCartCubit
                                    .quantityChanged(quantity.toString());

                                addToCartCubit.addToCart();
                              }
                            : null),
                  );
                }),
              ]),
            ),
          );
        },
      ),
    );
  }
}

class QuantityProduct extends StatefulWidget {
  final ValueChanged<int> onQuantityChanged;
  final int initialQuantity;
  const QuantityProduct({super.key, required this.onQuantityChanged, this.initialQuantity = 1});

  @override
  State<QuantityProduct> createState() => _QuantityProductState();
}

class _QuantityProductState extends State<QuantityProduct> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity; // 👈 gán từ initialQuantity
  }

  void _updateQuantity() {
    widget.onQuantityChanged(
        quantity); // Trigger callback to send updated quantity
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: context.colors.black.withOpacity(0.7))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (quantity > 1) {
                    quantity--;
                  }
                  _updateQuantity();
                });
              },
              child: Assets.icons.minus.svg(
                color: context.colors.black,
                width: 16,
                height: 16,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            AppText('$quantity',
                color: context.colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  quantity++;
                  _updateQuantity();
                });
              },
              child: Assets.icons.plus.svg(
                color: context.colors.black.withOpacity(0.7),
                width: 14,
                height: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
