import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/data/repository/cart_repository.dart';
import 'package:shoe_store/shared/cubits/add_to_cart_cubit/add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  final CartRepository cartRepository;
  AddToCartCubit({required this.cartRepository}) : super(AddToCartState());

  void userIdChanged(String userId) {
    emit(state.copyWith(userId: userId));
  }
  void quantityChanged(String quantity) {
    emit(state.copyWith(quantity: quantity));
  } 
  void variantIdChanged(String variantId) {
    emit(state.copyWith(variantId: variantId));
  }
  Future<void>addToCart()async{
    
    emit(state.copyWith(isLoading: true,addToCartSuccess: false));
    try{
      final params = state.toParams();
      print("🛒 [AddToCartCubit] Params gửi lên: $params");
      await cartRepository.addToCart(params);
      print("✅ [AddToCartCubit] Thêm vào giỏ hàng thành công");
      emit(state.copyWith(isLoading: false,addToCartSuccess: true));
    }catch(e){
      print("❌ [AddToCartCubit] Thêm vào giỏ hàng thất bại: $e");
      emit(state.copyWith(isLoading: false,addToCartSuccess: false));
    }
  }
  
}