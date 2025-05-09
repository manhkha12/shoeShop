import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/features/cart/cubit/cart_cubit.dart';
import 'package:shoe_store/features/peoduct_detail/bottom_sheet_content.dart';
import 'package:shoe_store/gen/assets.gen.dart';
import 'package:shoe_store/shared/extensions/extensions.dart';
import 'package:shoe_store/shared/widgets/app_text.dart';

class ShowCartItem extends StatefulWidget {
  final String? id;
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
    required this.id,
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
                          onQuantityChanged: (newQuantity) {
                            _onQuantityChanged(newQuantity);
                            context
                                .read<CartCubit>()
                                .updateQuantity(widget.id, newQuantity);
                            context
                                .read<CartCubit>()
                                .updateCartItem(widget.id, newQuantity);
                            // context.read<CartCubit>().calculateTotalPrice(context.read<CartCubit>().state.selectedItems);
                          },
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