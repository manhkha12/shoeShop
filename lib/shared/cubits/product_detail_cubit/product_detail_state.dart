import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoe_store/shared/models/detail.dart';


part 'product_detail_state.freezed.dart';

@freezed
class ProductDetailState with _$ProductDetailState {
  factory ProductDetailState({
    @Default(false) bool isLoading,
    @Default([]) List<Detail> productDetail,
    @Default(false) bool isSuccess,
    String? errorMessage,
  }) = _ProductDetailState;
}