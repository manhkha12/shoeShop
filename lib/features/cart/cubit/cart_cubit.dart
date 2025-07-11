import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/data/repository/cart_repository.dart';
import 'package:shoe_store/features/cart/cubit/cart_state.dart';
import 'package:shoe_store/shared/models/cart_item.dart';

class CartCubit extends Cubit<CartState> {
  CartRepository cartRepository;
  CartCubit({required this.cartRepository}) : super(CartState());

  Future<void> deleteCartItem(String? id) async {
    emit(state.copyWith(isLoading: true));
    try {
      await cartRepository.deleteCartItem(id);

      final updatedItems =
          state.cartItems.where((item) => item.cartId != id).toList();
      emit(state.copyWith(cartItems: updatedItems, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> updateCartItem(String? id, int quan) async {
    emit(state.copyWith(isLoading: true));
    try {
      await cartRepository.updateCartItem(id, quan);

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> getCartItems(String? userId) async {
    emit(state.copyWith(isLoading: true));
    try {
      final cartItems = await cartRepository.getCart(userId);
      if (cartItems != null) {
        emit(state.copyWith(
          cartItems: cartItems,
          isLoading: false,
          cartSuccess: true,
        ));
      } else {
        emit(state.copyWith(isLoading: false, cartSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, cartSuccess: false));
    }
  }

  void calculateTotalPrice(List<bool> selectedItems) {
    final cartItems = state.cartItems;
    double sum = 0;
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i]) {
        double price = 0;
        try {
          price = double.tryParse(cartItems[i].price ?? '0') ?? 0;
        } catch (e) {
          price = 0;
        }
        sum += price * (cartItems[i].quantity ?? 1);
      }
    }
    emit(state.copyWith(totalPrice: sum));
  }

  void updateQuantity(String? itemId, int newQuantity) {
    final updatedItems = state.cartItems.map((item) {
      if (item.cartId == itemId) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();

    emit(state.copyWith(cartItems: updatedItems));

    calculateTotalPrice(state.selectedItems);
  }

  List<CartItem> getSelectedCartItems(List<bool> selectedItems) {
    final selectedCartItems = <CartItem>[];

    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i]) {
        selectedCartItems.add(state.cartItems[i]);
      }
    }

    return selectedCartItems;
  }
}
