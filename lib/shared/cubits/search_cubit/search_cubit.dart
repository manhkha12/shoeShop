import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/data/repository/search_product_repository.dart';
import 'package:shoe_store/shared/cubits/search_cubit/search_state.dart';
import 'package:shoe_store/shared/models/product.dart'; // ✅ Thêm import

class SearchCubit extends Cubit<SearchState> {
  final SearchProductRepository searchProductRepository;
  SearchCubit({required this.searchProductRepository}) : super(SearchState());

  Future<void> searchProducts(String query) async {
    print("🔄 [SearchCubit] - Đang tìm kiếm sản phẩm với từ khóa: $query");
    emit(state.copyWith(isLoading: true, searchResults: []));

    try {
      final List<Product> results = await searchProductRepository.searchProducts(query);
      if (results.isNotEmpty) {
        
        print("✅ [SearchCubit] - Tìm thấy ${results.length} sản phẩm: $results");
        emit(state.copyWith(isLoading: false, searchResults: results));
      } else {
        print("❌ [SearchCubit] - Không tìm thấy sản phẩm nào!");
        emit(state.copyWith(
          isLoading: false,
          searchResults: [],
          errorMessage: 'Không tìm thấy sản phẩm nào!',
        ));
      }
    } catch (e) {
      print("❌ [SearchCubit] - Lỗi khi tìm kiếm sản phẩm: $e");
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
