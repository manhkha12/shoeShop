import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoe_store/shared/models/cart_item.dart';

part 'cart_state.freezed.dart';
@freezed

class CartState with _$CartState{
  factory CartState({
    @Default(false) bool isLoading,
    @Default(false) bool cartSuccess,
    @Default([]) List<CartItem> cartItems,
    @Default([]) List<bool> selectedItems,
    @Default(0.0) double totalPrice,
   
  }) = _CartState;
}