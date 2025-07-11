import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = "http://10.0.2.2:5000/api";

  Future<Map<String, dynamic>?> postRequest(
      String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/$endpoint"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
      } else {
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
      final response = await http.post(
        Uri.parse("$baseUrl/cart"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(params),
      );

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
    try {
      final response = await http.get(Uri.parse("$baseUrl/cart/$userId"));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse["data"]["results"];

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
}
