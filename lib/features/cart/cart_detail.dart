import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoe_store/features/cart/component/show_cart_item.dart';
import 'package:shoe_store/features/cart/cubit/cart_cubit.dart';
import 'package:shoe_store/features/cart/cubit/cart_state.dart';
import 'package:shoe_store/features/peoduct_detail/bottom_sheet_content.dart';
import 'package:shoe_store/gen/assets.gen.dart';
import 'package:shoe_store/routes.dart';
import 'package:shoe_store/shared/extensions/extensions.dart';
import 'package:shoe_store/shared/models/cart_item.dart';
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
  // List<CartItem> selectedCartItems = [];
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
    final totalPrice =
        context.select((CartCubit cubit) => cubit.state.totalPrice);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Giỏ hàng",
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cartItem = state.cartItems;
          if (selectedItems.length != state.cartItems.length) {
            selectedItems = List<bool>.filled(state.cartItems.length, false);
          }
          // selectedCartItems = <CartItem>[];
          // for (int i = 0; i < selectedItems.length; i++) {
          //   if (selectedItems[i]) {
          //     selectedCartItems.add(cartItem[i]);
          //   }
          // }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Dismissible(
                    key: ValueKey(
                        cartItem[index].cartId), // mỗi sản phẩm có id riêng
                    background: Container(
                      color: context.colors.textError,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: AppText('Xóa', color: context.colors.black),
                    ),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      // Nếu muốn hỏi confirm (Hiện Alert Dialog trước khi xóa), code ở đây
                      return true; // true = cho phép xóa
                    },
                    onDismissed: (direction) {
                      context
                          .read<CartCubit>()
                          .deleteCartItem(cartItem[index].cartId);
                      selectedItems
                          .removeAt(index); // nhớ xóa selectedItems tương ứng
                      context.read<CartCubit>().calculateTotalPrice(
                          selectedItems); // cập nhật lại tổng
                    },
                    child: ShowCartItem(
                      id: cartItem[index].cartId,
                      isChecked: selectedItems[index],
                      onChanged: (value) {
                        setState(() {
                          selectedItems[index] = value;
                          isChecked = selectedItems.every((element) =>
                              element); // nếu tất cả đều true thì check 'Tất cả'
                        });
                        context
                            .read<CartCubit>()
                            .calculateTotalPrice(selectedItems);
                      },
                      imageUrl: cartItem[index].image ?? "",
                      nameProduct: cartItem[index].name ?? "",
                      color: cartItem[index].color ?? "",
                      size: cartItem[index].size ?? "",
                      price: cartItem[index].price.toString(),
                      quantity: cartItem[index].quantity,
                    ),
                  ),
                  itemCount: cartItem.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 15,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: buildBottomBar(totalPrice),
    );
  }

  Widget buildBottomBar(double totalPrice) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.colors.white,
        border: Border.all(color: context.colors.divider),
      ),
      child: Row(
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
                context.read<CartCubit>().calculateTotalPrice(selectedItems);
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
          AppText('Tất cả', fontSize: 15, color: context.colors.black),
          SizedBox(width: 20),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Tổng tiền: ',
                    style: TextStyle(fontSize: 15, color: context.colors.black),
                  ),
                  TextSpan(
                    text: 'đ${totalPrice.toStringAsFixed(0)}',
                    style: TextStyle(
                        fontSize: 15, color: context.colors.textError),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            height: 45,
            width: context.width * 0.25,
            child: Material(
              elevation: 4,
              color: context.colors.onlineColor,
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                onTap: () {
                  final selectedItemsss = context
                      .read<CartCubit>()
                      .getSelectedCartItems(selectedItems);
                  Navigator.pushNamed(context, RouteName.orderScreen,
                      arguments: selectedItemsss);
                },
                child: Center(child: AppText('Mua hàng', fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
