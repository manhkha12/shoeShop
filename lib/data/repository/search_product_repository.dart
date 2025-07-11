import 'package:shoe_store/data/repository/api_service.dart';
import 'package:shoe_store/shared/models/product.dart';

class SearchProductRepository {
  ApiService apiService;
  SearchProductRepository({required this.apiService});

  Future<List<Product>> searchProducts(String query) async {
    final response = await apiService.searchProducts(query);

    if (response != null) {
      return response.map((data) => Product.fromJson(data)).toList();
    }

    return [];
  }
}
