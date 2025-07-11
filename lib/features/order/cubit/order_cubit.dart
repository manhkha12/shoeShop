import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/data/repository/order_repository.dart';
import 'package:shoe_store/features/order/cubit/order_state.dart';
import 'package:shoe_store/shared/models/cart_item.dart';
import 'package:shoe_store/shared/models/order_item.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderRepository orderRepository;
  OrderCubit({required this.orderRepository}) : super(OrderState());

  void setProductId(String? productId) {
    emit(state.copyWith(productId: productId));
  }

  void setColor(String? color) {
    emit(state.copyWith(color: color));
  }

  void setQuantity(int quantity) {
    emit(state.copyWith(quantity: quantity));
  }

  void setPrice(String? price) {
    emit(state.copyWith(price: price));
  }

  void setSize(String? size) {
    emit(state.copyWith(size: size));
  }

  void setTotalPrice(double? totalPrice) {
    emit(state.copyWith(totalPrice: totalPrice));
  }

  Future<void> getOrder (String? userId)async{
    print('dang lay order');
    emit(state.copyWith(isLoading: true));
    try{
      final orderItem = await orderRepository.getOrder(userId);
      emit(state.copyWith(
        isLoading: false,
        orders: orderItem,
        isOrderSuccess: true
      ));
    }catch(e){print("🚨 [OrderCubit] Lỗi khi tạo đơn hàng: $e");
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));}
  }

  Future<void> createOrder() async {
    print("📦 [OrderCubit] Đang tạo đơn hàng");
    emit(state.copyWith(isLoading: true));
    try {
      final orderParams = state.toOrderParams();
      final result = await orderRepository.createOrder(orderParams);
      if (result != null) {
        print("✅ [OrderCubit] Đã tạo đơn hàng thành công");
        emit(state.copyWith(
          isLoading: false,
          isOrderSuccess: true,
        ));
      } else {
        print("❌ [OrderCubit] Không nhận được kết quả từ repository");
        emit(state.copyWith(
            isLoading: false, errorMessage: "Failed to create order"));
      }
    } catch (e) {
      print("🚨 [OrderCubit] Lỗi khi tạo đơn hàng: $e");
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
