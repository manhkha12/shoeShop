import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/data/repository/cart_repository.dart';
import 'package:shoe_store/features/cart/cubit/cart_state.dart';
import 'package:shoe_store/shared/models/cart_item.dart';

class CartCubit extends Cubit<CartState> {
  CartRepository cartRepository;
  CartCubit({required this.cartRepository}) : super(CartState());

  Future<void> deleteCartItem(String? id) async {
    print("🗑️ [CartCubit] Đang xóa sản phẩm với cartId: $id");
    emit(state.copyWith(isLoading: true));
    try {
      await cartRepository.deleteCartItem(id);
      print("✅ [CartCubit] Đã xóa sản phẩm khỏi giỏ hàng với cartId: $id");
      final updatedItems =
          state.cartItems.where((item) => item.cartId != id).toList();
      emit(state.copyWith(cartItems: updatedItems, isLoading: false));
    } catch (e) {
      print("🚨 [CartCubit] Lỗi khi xóa sản phẩm khỏi giỏ hàng: $e");
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> updateCartItem(String? id, int quan) async {
    print("🛒 [CartCubit] Đang cập nhật sản phẩm với cartId: $id");
    emit(state.copyWith(isLoading: true));
    try {
      await cartRepository.updateCartItem(id, quan);
      print("✅ [CartCubit] Đã cập nhật sản phẩm với cartId: $id");
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      print("🚨 [CartCubit] Lỗi khi cập nhật sản phẩm: $e");
      emit(state.copyWith(isLoading: false));
    }
  }

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

    // 👉 Thêm luôn dòng này sau khi emit
    calculateTotalPrice(state.selectedItems);
  }

  List<CartItem> getSelectedCartItems(List<bool> selectedItems) {
    final selectedCartItems = <CartItem>[];
    print("🛒 [CartCubit] Đang lấy danh sách sản phẩm đã chọn");
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i]) {
        selectedCartItems.add(state.cartItems[i]);
      }
    }
    print("✅ [CartCubit] Đã lấy danh sách sản phẩm đã chọn thành công");
    print(selectedCartItems);

    return selectedCartItems;
  }
}
