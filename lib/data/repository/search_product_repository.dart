import 'package:shoe_store/data/repository/api_service.dart';
import 'package:shoe_store/shared/models/product.dart';

class SearchProductRepository {
ApiService apiService;
SearchProductRepository({required this.apiService});

  Future<List<Product>> searchProducts(String query) async {
    print("🔄 [SearchProductRepository] - Đang tìm kiếm sản phẩm với từ khóa: $query");

    final response = await apiService.searchProducts(query);

    if (response != null) {
      print("✅ [SearchProductRepository] - Tìm thấy ${response.length} sản phẩm.");
      return response.map((data) => Product.fromJson(data)).toList();
    }

    print("❌ [SearchProductRepository] - Không tìm thấy sản phẩm nào!");
    return [];
  }

}