import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/shared/cubits/product_detail_cubit/product_detail_cubit.dart';
import 'package:shoe_store/shared/cubits/product_detail_cubit/product_detail_state.dart';
import 'package:shoe_store/shared/extensions/build_context_extension.dart';
import 'package:shoe_store/shared/models/detail.dart';
import 'package:shoe_store/shared/models/product.dart';
import 'package:shoe_store/shared/widgets/app_text.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailCubit>().loadProductDetail(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Chi tiết sản phẩm",
        titleFontSize: 20,
        titleFontWeight: FontWeight.bold,
      ),
      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.productDetail.isEmpty) {
          return Center(child: Text("Không có dữ liệu chi tiết"));
        }
        final detail = state.productDetail.first;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: context.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.product.imageUrl ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: context.colors.black,
                ),
                SizedBox(
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
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: context.colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                AppText(
                  "Mô tả ",
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 5,
                ),
                AppText(
                  detail.category?.name ?? "",
                  fontSize: 16,
                ),
                AppText(detail.category?.description ?? ""),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
