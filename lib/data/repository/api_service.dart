import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = "http://10.0.2.2:5000/api";

  Future<Map<String, dynamic>?> postRequest(
      String endpoint, Map<String, dynamic> body) async {
    print('[ApiService] 🔄 Đang gửi yêu cầu POST đến endpoint: $endpoint');
    print('[ApiService] 📤 Dữ liệu gửi đi: $body');
    print('[ApiService] 🌍 Base URL: $baseUrl'); // Kiểm tra giá trị của baseUrl

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/$endpoint"), // Gọi API với đúng endpoint
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print('[ApiService] ✅ Đáp ứng thành công từ server: ${response.body}');
        return jsonDecode(response.body);
      } else {
        print(
            '[ApiService] ❌ Lỗi khi gửi yêu cầu, mã trạng thái: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('[ApiService] ❌ Lỗi khi gửi yêu cầu: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getProducts() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/products"));
      // print(
      //     "🛠 [API Service] - Kết nối API, mã trạng thái: ${response.statusCode}");
      // print("📩 [API Service] - Dữ liệu trả về: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse["data"];
        return data
            .map((product) => {
                  "product_id": product["product_id"].toString(),
                  "name": product["name"],
                  "price": product["price"],
                  "image": product["image"],
                  "stock": product["stock"].toString()
                })
            .toList();
      }
      return null;
    } catch (e) {
      print("🚨 [API Service] - Lỗi khi lấy dữ liệu từ API: $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getProductDetail(String productId) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/products/$productId"));
      print(
          "🛠 [API Service] - Kết nối API, mã trạng thái: ${response.statusCode}");
      print("📩 [API Service] - Dữ liệu trả về: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        Map<String, dynamic> data = jsonResponse["data"];

        return [
          {
            "category": data["category"],
            "variants": data["variants"],
          }
        ];
      }
      return null;
    } catch (e) {
      print("🚨 [API Service] - Lỗi khi lấy dữ liệu từ API: $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> searchProducts(String query) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/products/search?query=$query"));
      // print(
      //     "🛠 [API Service] - Kết nối API, mã trạng thái: ${response.statusCode}");
      // print("📩 [API Service] - Dữ liệu trả về: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse["products"];
        return data
            .map((product) => {
                  "product_id": product["product_id"].toString(),
                  "name": product["name"],
                  "price": product["price"],
                  "image": product["image"],
                })
            .toList();
      }
      return null;
    } catch (e) {
      print("🚨 [API Service] - Lỗi khi lấy dữ liệu từ API: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> authToken(String refreshToken) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/refresh_token"),
        headers: {
          'Authorization': 'Bearer $refreshToken',
          'Content-Type': 'application/json',
        },
      );

      // print(
      //     "🔐 [API Service] - Kiểm tra token, mã trạng thái: ${response.statusCode}");
      // print("📩 [API Service] - Dữ liệu trả về: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      // print("🚨 [API Service] - Lỗi khi xác thực token: $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getReviewProduct(String productId) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/review/product/$productId"));
      // print(
      //     "🛠 [API Service] - Kết nối API, mã trạng thái: ${response.statusCode}");
      // print("📩 [API Service] - Dữ liệu trả về: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse["data"];

        // Trả về danh sách review
        return data
            .map<Map<String, dynamic>>((review) => {
                  "review_id": review["review_id"].toString(),
                  "user_id": review["user_id"].toString(),
                  "product_id": review["product_id"].toString(),
                  "rating": review["rating"],
                  "comment": review["comment"],
                  "created_at": review["created_at"],
                  "username": review["username"],
                })
            .toList();
      }

      return null;
    } catch (e) {
      // print("🚨 [API Service] - Lỗi khi lấy dữ liệu từ API: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> addReview(Map<String, dynamic> review) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/review"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(review),
      );

      // print(
      //     "🛠 [API Service] - Kết nối API, mã trạng thái: ${response.statusCode}");
      // print("📩 [API Service] - Dữ liệu trả về: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      // print("🚨 [API Service] - Lỗi khi gửi dữ liệu đánh giá: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> addToCart(Map<String, dynamic> params) async {
    try {
      print("🌐 [ApiService] Gửi POST $baseUrl/cart với body: $params");
      final response = await http.post(
        Uri.parse("$baseUrl/cart"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(params),
      );
      print(
          "📨 [ApiService] Response: ${response.statusCode} - ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      // print("🚨 [API Service] - Lỗi khi gửi dữ liệu đánh giá: $e");
      print("🚨 [ApiService] Lỗi khi gọi API: $e");
      return null;
    }
  }

  Future<void> deleteCartItem(String? cartId) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/cart/$cartId"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print("✅ [ApiService] Xóa sản phẩm khỏi giỏ hàng thành công!");
      } else {
        print(
            "❌ [ApiService] Lỗi khi xóa sản phẩm khỏi giỏ hàng, mã trạng thái: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 [ApiService] Lỗi khi gọi API: $e");
    }
  }

  Future<void> updateCartItem(String? cartId, int quan) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/cart/$cartId"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: {
          'quantity': quan,
        },
      );
      if (response.statusCode == 200) {
        print("✅ [ApiService] Cập nhật sản phẩm trong giỏ hàng thành công!");
      } else {
        print(
            "❌ [ApiService] Lỗi khi cập nhật sản phẩm trong giỏ hàng, mã trạng thái: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 [ApiService] Lỗi khi gọi API: $e");
    }
  }

  Future<List<Map<String, dynamic>>?> getCart(String? userId) async {
    print(
        "🛒 [ApiService] Gửi request đến API để lấy giỏ hàng cho userId: $userId");
    try {
      final response = await http.get(Uri.parse("$baseUrl/cart/$userId"));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse["data"]["results"];
        print(
            "✅ [ApiService] Nhận được ${data.length} sản phẩm trong giỏ hàng");
        return data
            .map((cartItem) => {
                  "cart_id": cartItem["cart_id"].toString(),
                  "product_id": cartItem["product_id"].toString(),
                  "quantity": cartItem["quantity"],
                  'variant_id': cartItem["variant_id"].toString(),
                  "name": cartItem["name"],
                  "price": cartItem["price"],
                  "image": cartItem["image"],
                  'size': cartItem["size"],
                  'color': cartItem["color"],
                })
            .toList();
      } else {
        print(
            "❌ [ApiService] Lỗi từ API với status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("🚨 [API Service] - Lỗi khi lấy dữ liệu từ API: $e");
      return null;
    }
  }

Future<List<Map<String, dynamic>>?> getUserOrders(String? userId) async {
   // Thay URL thật của bạn

  try {
    final response = await http.get(Uri.parse("$baseUrl/order/user/$userId"));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
         print("🟢 [ApiService] JSON Response: $jsonResponse");
      if (jsonResponse['success'] == true) {
        List<dynamic> orders = jsonResponse['data']['orders'];
         print("🟢 [ApiService] Lấy được ${orders.length} orders");
        // Trả về list map orders (đã có items bên trong)
        // In từng order
        for (var order in orders) {
          print("Order ID: ${order['order_id']}, Total: ${order['total_price']}");
          print("Items: ${order['items']}");
        }
        
        return orders.cast<Map<String, dynamic>>();
      } else {
        print('API trả về lỗi hoặc không thành công');
        return null;
      }
    } else {
      print('Lỗi HTTP: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Lỗi gọi API: $e');
    return null;
  }
}


  Future<Map<String, dynamic>?> createOrder(Map<String, dynamic> params,String? accessToken) async {
    try {
      print("🌐 [ApiService] Gửi POST $baseUrl/order với body: $params");
      final response = await http.post(
        Uri.parse("$baseUrl/order"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(params),
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print("✅ [ApiService] Đơn hàng đã được tạo: $jsonResponse");
        return jsonResponse; // chứa: { message, orderId }
      } else {
        print("❌ [ApiService] Lỗi từ API với status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("🚨 [ApiService] Lỗi khi gọi API tạo đơn hàng: $e");
      return null;
    }
  }
}
