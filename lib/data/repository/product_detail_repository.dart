import 'package:shoe_store/data/repository/api_service.dart';
import 'package:shoe_store/features/peoduct_detail/product_detail.dart';
import 'package:shoe_store/shared/models/detail.dart';

class ProductDetailRepository {
  ApiService apiService;
  ProductDetailRepository({required this.apiService});

Future<List<Detail>> getProductDetail(String productId) async {
  print("🔄 [ProductDetailRepository] - Đang lấy danh sách sản phẩm...");
  final response = await apiService.getProductDetail(productId);

  if (response != null) {
   final productDetail=  response.map((data) => Detail.fromJson(data)).toList();
   print("✅ [ProductRepository] - Lấy thành công ${productDetail.length} sản phẩm.");
    return productDetail;
 }
    print("❌ [ProductRepository] - Không lấy được sản phẩm nào!");
  return [];
}
}
