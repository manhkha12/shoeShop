import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoe_store/features/cart/cubit/cart_cubit.dart';
import 'package:shoe_store/features/cart/cubit/cart_state.dart';
import 'package:shoe_store/features/peoduct_detail/bottom_sheet_content.dart';
import 'package:shoe_store/gen/assets.gen.dart';
import 'package:shoe_store/shared/extensions/extensions.dart';
import 'package:shoe_store/shared/widgets/app_text.dart';
import 'package:shoe_store/shared/widgets/buttons/app_button.dart';
import 'package:shoe_store/shared/widgets/custom_app_bar.dart';

class CartDetail extends StatefulWidget {
  const CartDetail({super.key});

  @override
  State<CartDetail> createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  String? userId;
  bool isChecked = false;
  List<bool> selectedItems = [];
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id')?.toString();
    print('userId: $userId');

    if (mounted && userId != null) {
      context.read<CartCubit>().getCartItems(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Giỏ hàng",
      ),
      body: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
        final cartItem = state.cartItems;
        if (selectedItems.length != state.cartItems.length) {
          selectedItems = List<bool>.filled(state.cartItems.length, false);
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => ShowCartItem(
                  isChecked: selectedItems[index],
                  onChanged: (value) {
                    setState(() {
                      selectedItems[index] = value;
                      isChecked = selectedItems.every((element) =>
                          element); // nếu tất cả đều true thì check 'Tất cả'
                    });
                  },
                  imageUrl: cartItem[index].image ?? "",
                  nameProduct: cartItem[index].name ?? "",
                  color: cartItem[index].color ?? "",
                  size: cartItem[index].size ?? "",
                  price: cartItem[index].price.toString(),
                  quantity: cartItem[index].quantity,
                ),
                itemCount: cartItem.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
              ),
            ),
          ),
        );
      }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: context.colors.white,
          border: Border.all(
            color: context.colors.divider,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                    selectedItems =
                        List<bool>.filled(selectedItems.length, isChecked);
                  });
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isChecked
                          ? context.colors.textError
                          : context.colors.black.withOpacity(0.7),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: isChecked
                        ? context.colors.textError
                        : context.colors.white,
                  ),
                  child: isChecked
                      ? Assets.icons.tick.svg(color: context.colors.white)
                      : null,
                ),
              ),
            ),
            AppText(
              'Tất cả',
              fontSize: 15,
              color: context.colors.black,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Tổng tiền: ',
                    style: TextStyle(
                      fontSize: 15,
                      color: context.colors.black,
                    ),
                  ),
                  TextSpan(
                    // text: 'đ${context.watch<CartCubit>().state.totalPrice.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 15,
                      color: context.colors.textError,
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 45,
              width: context.width * 0.25,
              decoration: BoxDecoration(),
              child: Material(
                elevation: 4,
                color: context.colors.onlineColor,
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  onTap: () {},
                  child: Center(
                      child: AppText(
                    'Mua hang',
                    fontSize: 16,
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowCartItem extends StatefulWidget {
  final String color;
  final String size;
  final String price;
  final int? quantity;
  final String nameProduct;
  final String imageUrl;
  final bool isChecked; // <-- thêm
  final Function(bool) onChanged; // <-- thêm
  ShowCartItem({
    super.key,
    required this.imageUrl,
    required this.nameProduct,
    required this.color,
    required this.size,
    required this.price,
    required this.quantity,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  State<ShowCartItem> createState() => _ShowCartItemState();
}

class _ShowCartItemState extends State<ShowCartItem> {
  bool isOntap = false;
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity ?? 1;
  }

  void _onQuantityChanged(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.isChecked
                        ? context.colors.textError
                        : context.colors.black.withOpacity(0.7),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: widget.isChecked
                      ? context.colors.textError
                      : context.colors.white,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      // isOntap = !isOntap;
                      widget.onChanged(!widget.isChecked);
                    });
                  },
                  child: widget.isChecked
                      ? Assets.icons.tick.svg(color: context.colors.white)
                      : null,
                )),
            SizedBox(
              width: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      widget.nameProduct,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 30,
                      width: 85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: context.colors.black.withOpacity(0.5)),
                          color: context.colors.dimGrey),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Center(
                          child: AppText(
                            '${widget.color} - ${widget.size}',
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Row(
                      children: [
                        AppText(
                          'đ${widget.price}',
                          fontSize: 15,
                          color: context.colors.textError,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        QuantityProduct(
                          onQuantityChanged: _onQuantityChanged,
                          initialQuantity: quantity,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
