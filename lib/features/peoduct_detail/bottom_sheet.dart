import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shoe_store/features/peoduct_detail/bottom_sheet_content.dart';
import 'package:shoe_store/gen/assets.gen.dart';
import 'package:shoe_store/shared/cubits/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:shoe_store/shared/cubits/product_detail_cubit/product_detail_cubit.dart';
import 'package:shoe_store/shared/cubits/product_detail_cubit/product_detail_state.dart';
import 'package:shoe_store/shared/extensions/extensions.dart';
import 'package:shoe_store/shared/models/product.dart';
import 'package:shoe_store/shared/widgets/app_text.dart';
import 'package:shoe_store/shared/widgets/app_text_icon.dart';

void bottomSheet(BuildContext context, Product product,{
  Function()? onAddToCartSuccess, // 👈 Thêm callback
} ) {
  final productDetailCubit = context.read<ProductDetailCubit>();
  
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      
      return MultiBlocProvider(
        providers: [BlocProvider.value(
            value: productDetailCubit,),
            BlocProvider(create: (_)=>GetIt.I<AddToCartCubit>(),),
            
            ],
        
            child: BottomSheetContent(product: product,onAddToCartSuccess: onAddToCartSuccess,),
      );
    },
  );
}

class TextClickButton extends StatelessWidget {
  final String? text;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool isDisabled;

  const TextClickButton({
    super.key,
    required this.text,
    required this.isSelected,
    this.isDisabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDisabled
        ? context.colors.dimGrey
        : isSelected
            ? context.colors.lightBorder
            : context.colors.dimGrey.withOpacity(0.4);

    final borderColor = isSelected
        ? context.colors.easyColor
        : context.colors.dimGrey;
    return GestureDetector(
      onTap:  isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border:
              Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(8),
          color:
              bgColor,
        ),
        child: AppText(text ?? '',color: isDisabled?context.colors.disableIcon:context.colors.black,),
      ),
    );
  }
}
