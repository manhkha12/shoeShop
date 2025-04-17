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
      print(
          "🛠 [API Service] - Kết nối API, mã trạng thái: ${response.statusCode}");
      print("📩 [API Service] - Dữ liệu trả về: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse["data"];
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
      print(
          "🛠 [API Service] - Kết nối API, mã trạng thái: ${response.statusCode}");
      print("📩 [API Service] - Dữ liệu trả về: ${response.body}");

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

  Future<Map<String, dynamic>?> authToken(String refeshToken) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/auth/refesh_token"),
        headers: {
          'Authorization': 'Bearer $refeshToken',
          'Content-Type': 'application/json',
        },
      );

      print(
          "🔐 [API Service] - Kiểm tra token, mã trạng thái: ${response.statusCode}");
      print("📩 [API Service] - Dữ liệu trả về: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("🚨 [API Service] - Lỗi khi xác thực token: $e");
      return null;
    }
  }
}
