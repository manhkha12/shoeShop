

import 'package:shoe_store/data/repository/api_service.dart';
import 'package:shoe_store/shared/models/product.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository({required this.apiService});

  Future<List<Product>> fetchProducts() async {
    // print("🔄 [ProductRepository] - Đang lấy danh sách sản phẩm...");
    final rawProducts = await apiService.getProducts();

    if (rawProducts != null) {
      final products = rawProducts.map((e) => Product.fromJson(e)).toList();
      // print("✅ [ProductRepository] - Lấy thành công ${products.length} sản phẩm.");
      return products;
    }

    // print("❌ [ProductRepository] - Không lấy được sản phẩm nào!");
    return [];
  }
}