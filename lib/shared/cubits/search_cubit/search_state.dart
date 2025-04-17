import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoe_store/shared/models/product.dart'; // Thêm import model Product

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  factory SearchState({
    @Default(false) bool isLoading,
    @Default([]) List<Product> searchResults, 
    String? errorMessage,
  }) = _SearchState;
  SearchState._();
}
