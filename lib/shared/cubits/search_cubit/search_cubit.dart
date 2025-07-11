import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_store/data/repository/search_product_repository.dart';
import 'package:shoe_store/shared/cubits/search_cubit/search_state.dart';
import 'package:shoe_store/shared/models/product.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchProductRepository searchProductRepository;
  SearchCubit({required this.searchProductRepository}) : super(SearchState());

  Future<void> searchProducts(String query) async {
    emit(state.copyWith(isLoading: true, searchResults: []));

    try {
      final List<Product> results =
          await searchProductRepository.searchProducts(query);
      if (results.isNotEmpty) {
        emit(state.copyWith(isLoading: false, searchResults: results));
      } else {
        emit(state.copyWith(
          isLoading: false,
          searchResults: [],
          errorMessage: 'Không tìm thấy sản phẩm nào!',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
