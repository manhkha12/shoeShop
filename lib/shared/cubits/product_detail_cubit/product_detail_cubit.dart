import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/data/repository/product_detail_repository.dart';
import 'package:shoe_store/shared/cubits/product_detail_cubit/product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailRepository productDetailRepository;
  ProductDetailCubit({required this.productDetailRepository})
      : super(ProductDetailState());

  Future<void> loadProductDetail(String productId) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    final productDetail =
        await productDetailRepository.getProductDetail(productId);

    if (productDetail.isNotEmpty) {
      emit(state.copyWith(
          isLoading: false, productDetail: productDetail, isSuccess: true));
    } else {
      emit(state.copyWith(isLoading: false, productDetail: []));
    }
  }
}
