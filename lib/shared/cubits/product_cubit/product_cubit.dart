import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/data/repository/product_reponsitory.dart';

import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit({required this.productRepository}) : super(ProductState());

  Future<void> loadProducts() async {
    emit(state.copyWith(isLoading: true));

    final products = await productRepository.fetchProducts();

    if (products.isNotEmpty) {
      emit(state.copyWith(isLoading: false, products: products));
    } else {
      emit(state.copyWith(isLoading: false, products: []));
    }
  }
}
