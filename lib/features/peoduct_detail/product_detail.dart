import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/features/peoduct_detail/animation.dart';
import 'package:shoe_store/features/peoduct_detail/bottom_sheet.dart';
import 'package:shoe_store/features/peoduct_detail/review.dart';
import 'package:shoe_store/gen/assets.gen.dart';
import 'package:shoe_store/routes.dart';
import 'package:shoe_store/shared/cubits/product_detail_cubit/product_detail_cubit.dart';
import 'package:shoe_store/shared/cubits/product_detail_cubit/product_detail_state.dart';
import 'package:shoe_store/shared/cubits/review_cubit/review_cubit.dart';
import 'package:shoe_store/shared/cubits/review_cubit/review_state.dart';
import 'package:shoe_store/shared/extensions/build_context_extension.dart';
import 'package:shoe_store/shared/models/product.dart';
import 'package:shoe_store/shared/widgets/app_text.dart';
import 'package:shoe_store/shared/widgets/buttons/app_button.dart';
import 'package:shoe_store/shared/widgets/custom_app_bar.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  const ProductDetail({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final GlobalKey cartKey = GlobalKey();
  final GlobalKey productKey = GlobalKey();

  void startAddToCartAnimation() {
    final overlay = Overlay.of(context);
    final renderBoxProduct =
        productKey.currentContext!.findRenderObject() as RenderBox;
    final renderBoxCart =
        cartKey.currentContext!.findRenderObject() as RenderBox;

    final productPosition = renderBoxProduct.localToGlobal(Offset.zero);
    final cartPosition = renderBoxCart.localToGlobal(Offset.zero);
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return AnimatedAddToCart(
          startPosition: productPosition,
          imageUrl: widget.product.imageUrl ?? "",
          endPosition: cartPosition,
          onEnd: () {
            overlayEntry.remove();
          },
        );
      },
    );

    overlay.insert(overlayEntry);
  }

  @override
  void initState() {
    super.initState();
    context.read<ProductDetailCubit>().loadProductDetail(widget.product.id);
    context.read<ReviewCubit>().loadReviews(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Chi tiết sản phẩm",
        titleFontSize: 20,
        titleFontWeight: FontWeight.bold,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
                key: cartKey,
                onTap: () {
                  Navigator.pushNamed(context, RouteName.cartDetail);
                },
                child: Assets.icons.cart.svg()),
          )
        ],
      ),
      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.productDetail.isEmpty) {
          return const Center(child: Text("Không có dữ liệu chi tiết"));
        }
        final detail = state.productDetail.first;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: context.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: CachedNetworkImage(
                      imageUrl: widget.product.imageUrl ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Divider(
                  color: context.colors.black,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppText(
                        widget.product.name,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppText(
                      "Giá: ${widget.product.price} VNĐ",
                      fontSize: 12,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: context.colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                const AppText(
                  "Mô tả ",
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                AppText(
                  detail.category?.name ?? "",
                  fontSize: 16,
                ),
                AppText(detail.category?.description ?? ""),
                const SizedBox(
                  height: 20,
                ),
                const AppText(
                  "Đánh giá sản phẩm",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                BlocBuilder<ReviewCubit, ReviewState>(
                    builder: (context, state) {
                  return Container(
                    child: state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : state.reviews.isEmpty
                            ? const Center(
                                child: Text("Chưa có đánh giá nào"),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final review = state.reviews[index];
                                  return ReviewItemWidget(
                                      username: review.username,
                                      comment: review.comment,
                                      createdAt: review.createdAt.toString(),
                                      rating: review.rating);
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 5,
                                ),
                                itemCount: state.reviews.length,
                              ),
                  );
                }),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Container(
          height: 63,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: context.colors.divider,
            ),
            boxShadow: [
              BoxShadow(
                color: context.colors.placeholderColor.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Container(
                  height: 43,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color:
                            context.colors.placeholderColor.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: context.width * 0.3,
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    color: context.colors.placeholderColor.withOpacity(0.1),
                    child: InkWell(
                      key: productKey,
                      onTap: () => bottomSheet(
                        context,
                        widget.product,
                        onAddToCartSuccess: startAddToCartAnimation,
                      ),
                      child: Assets.icons.cart.svg(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: AppButton(
                  primaryColor: context.colors.easyColor,
                  label: "Mua ngay",
                  onPressed: () {},
                )),
              ],
            ),
          )),
    );
  }
}
