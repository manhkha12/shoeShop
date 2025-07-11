import 'package:shoe_store/data/local/app_provider.dart';
import 'package:shoe_store/data/repository/api_service.dart';
import 'package:shoe_store/shared/models/order_item.dart';

class OrderRepository {
  ApiService apiService;
   final AppProvider appProvider;
  OrderRepository({required this.apiService, required this.appProvider});

  Future<Map<String, dynamic>?> createOrder(Map<String, dynamic> params) async {
    final accessToken =appProvider.accessToken;
    final result = await apiService.createOrder(params, accessToken);
    print("📦 [OrderRepository] Gửi yêu cầu tạo đơn hàng với params: $params");
    return result; // có thể trả về orderId để điều hướng
  }


Future<List<OrderItem>?>getOrder (String? userId)async{
   print("🟢 [Repo] Bắt đầu lấy order cho userId: $userId");
  final response = await apiService.getUserOrders(userId);
  if (response == null) return null;

  try {
    // response là List<Map<String, dynamic>> rồi
    
    return response
        .map((orderMap) => OrderItem.fromJson(orderMap))
        .toList();
        
  } catch (e) {
    print('Lỗi parse OrderItem: $e');
    return null;
  }
}  
}




  /// Tạo đơn hàng
  ///
  /// [params] là các tham số cần thiết để tạo đơn hàng.
  /// Trả về một Future<void> khi hoàn thành.
  ///
  /// Ví dụ:
  /// ```dart
  /// await orderRepository.createOrder({
  ///   'userId': '123',
  ///   'productId': '456',
  ///   'quantity': 2,
  /// });
  /// ```


