import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/data/repository/cart_repository.dart';
import 'package:shoe_store/features/cart/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartRepository cartRepository;
  CartCubit({required this.cartRepository}) : super(CartState());

  Future<void> getCartItems(String? userId) async {
    print("🛒 [CartCubit] Đang tải giỏ hàng cho userId: $userId");
    emit(state.copyWith(isLoading: true));
    try {
      final cartItems = await cartRepository.getCart(userId);
      if (cartItems != null) {
        print("✅ [CartCubit] Đã nhận giỏ hàng thành công");
        emit(state.copyWith(
          cartItems: cartItems,
          isLoading: false,
          cartSuccess: true,
          selectedItems: List.filled(cartItems.length, false),
        ));
      } else {
        print("❌ [CartCubit] Không nhận được giỏ hàng từ repository");
        emit(state.copyWith(isLoading: false, cartSuccess: false));
      }
    } catch (e) {
      print("🚨 [CartCubit] Lỗi khi lấy giỏ hàng: $e");
      emit(state.copyWith(isLoading: false, cartSuccess: false));
    }
  }

  // void toggleSelectItem(int index) {
  //   final updatedSelectedItems = List<bool>.from(state.selectedItems);
  //   updatedSelectedItems[index] = !updatedSelectedItems[index];
  //   emit(state.copyWith(selectedItems: updatedSelectedItems));
  //   calculateTotalPrice();
  // }

  // void selectAllItems(bool selectAll) {
  //   final updatedSelectedItems = List.filled(state.cartItems.length, selectAll);
  //   emit(state.copyWith(selectedItems: updatedSelectedItems));
  //   calculateTotalPrice();
  // }

  // void calculateTotalPrice() {
  //   double total = 0.0;
  //   for (int i = 0; i < state.cartItems.length; i++) {
  //     if (state.selectedItems[i]) {
  //       final priceString = state.cartItems[i].price;
  //       final price = double.tryParse(priceString ?? '') ??
  //           0.0; // chuyển String -> double
  //       final quantity =
  //           (state.cartItems[i].quantity as int?) ?? 1; // ép về int
  //       total += price * quantity;
  //     }
  //   }
  //   emit(state.copyWith(totalPrice: total));
  // }
}
