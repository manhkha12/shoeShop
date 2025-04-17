import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/data/repository/product_reponsitory.dart';

import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit({required this.productRepository}) : super(ProductState());

  Future<void> loadProducts() async {
    print("📢 [ProductCubit] - Bắt đầu tải danh sách sản phẩm...");
    emit(state.copyWith(isLoading: true));

    final products = await productRepository.fetchProducts();

    if (products.isNotEmpty) {
      print("✅ [ProductCubit] - Đã tải được ${products.length} sản phẩm.");
      emit(state.copyWith(isLoading: false, products: products));
    } else {
      print("❌ [ProductCubit] - Không có sản phẩm nào để hiển thị.");
      emit(state.copyWith(isLoading: false, products: []));
    }
  }
}
