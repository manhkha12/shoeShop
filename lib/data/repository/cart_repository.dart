import 'package:shoe_store/data/local/app_provider.dart';
import 'package:shoe_store/data/repository/api_service.dart';
import 'package:shoe_store/shared/models/cart_item.dart';

class CartRepository {
  ApiService apiService;
  
  CartRepository({required this.apiService});
  Future<void>addToCart(Map<String,dynamic>params)async{
    await apiService.addToCart(params);
    print("📦 [CartRepository] Gửi request đến API với params: $params");
  }
  Future<List<CartItem>?> getCart(String? userId)async{
    print("🛒 [CartRepository] Đang lấy giỏ hàng cho userId: $userId");
    final response = await apiService.getCart(userId);
    if (response != null) {
      List<CartItem> cartItems = response.map<CartItem>((item) => CartItem.fromJson(item)).toList();
      print("✅ [CartRepository] Đã nhận giỏ hàng với ${cartItems.length} item(s)");
      return cartItems;
    }else{
      print("❌ [CartRepository] Không nhận được dữ liệu từ API");
      return null;
    }
  }

}
  