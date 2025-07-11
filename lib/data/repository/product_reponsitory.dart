import 'package:shoe_store/data/repository/api_service.dart';
import 'package:shoe_store/shared/models/product.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository({required this.apiService});

  Future<List<Product>> fetchProducts() async {
    final rawProducts = await apiService.getProducts();

    if (rawProducts != null) {
      final products = rawProducts.map((e) => Product.fromJson(e)).toList();

      return products;
    }

    return [];
  }
}
