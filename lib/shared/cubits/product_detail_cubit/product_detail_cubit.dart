import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/data/repository/product_detail_repository.dart';
import 'package:shoe_store/shared/cubits/product_detail_cubit/product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailRepository productDetailRepository;
  ProductDetailCubit({required this.productDetailRepository}) : super(ProductDetailState());


  Future<void> loadProductDetail(String productId)async{
    print("📢 [ProductDetailCubit] - Bắt đầu tải danh sách sản phẩm...");
    emit(state.copyWith(isLoading: true));
    final productDetail = await productDetailRepository.getProductDetail(productId);

    if(productDetail.isNotEmpty){
      final detail = productDetail.first;
    print("✅ [ProductDetailCubit] - Đã parse thành model:");
    print("  🔹 Category name: ${detail.category?.name}");
    print("  🔹 Category description: ${detail.category?.description}");
    print("  🔹 Variant count: ${detail.variants.length}");
    for (var variant in detail.variants) {
      print("    ➜ Variant: size=${variant.size}, color=${variant.color}, stock=${variant.stock}");
    }
      emit(state.copyWith(isLoading: false, productDetail: productDetail));
  }else {
      print("❌ [ProductDetailCubit] - Không có sản phẩm nào để hiển thị.");
      emit(state.copyWith(isLoading: false, productDetail: []));
  }
  }
}