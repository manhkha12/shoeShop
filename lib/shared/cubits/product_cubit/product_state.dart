import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:shoe_store/shared/models/product.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  factory ProductState({
    @Default(false) bool isLoading,
    @Default([]) List<Product> products,
    String? errorMessage,
  }) = _ProductState;
}
