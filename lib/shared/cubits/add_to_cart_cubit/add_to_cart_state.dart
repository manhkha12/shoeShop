
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_to_cart_state.freezed.dart';

@freezed
class AddToCartState with _$AddToCartState {
   factory AddToCartState({
    @Default(false) bool isLoading,
    @Default(false) bool addToCartSuccess,
    String? userId,
    String? quantity,
    String? variantId,
  }) = _AddToCartState;

   AddToCartState._();


  Map<String,dynamic>toParams(){
    return {
      "user_id":userId,
      "variant_id":variantId,
      "quantity":quantity,
      
    };
  }

}