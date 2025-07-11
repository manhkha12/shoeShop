import 'package:shoe_store/data/repository/api_service.dart';
import 'package:shoe_store/features/peoduct_detail/product_detail.dart';
import 'package:shoe_store/shared/models/detail.dart';

class ProductDetailRepository {
  ApiService apiService;
  ProductDetailRepository({required this.apiService});

  Future<List<Detail>> getProductDetail(String productId) async {
    final response = await apiService.getProductDetail(productId);

    if (response != null) {
      final productDetail =
          response.map((data) => Detail.fromJson(data)).toList();

      return productDetail;
    }

    return [];
  }
}
