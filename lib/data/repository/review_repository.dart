import 'package:shoe_store/data/repository/api_service.dart';
import 'package:shoe_store/shared/models/review.dart';

class ReviewRepository {
  ApiService apiService;
  ReviewRepository({required this.apiService});

  Future<List<Review>> getReviews(String productId) async {
    try {
      // Log: In ra productId trước khi gọi API
      // print("Đang lấy reviews cho sản phẩm với ID: $productId");

      final resp = await apiService.getReviewProduct(productId);

      // Log: In ra phản hồi từ server
      // print("Dữ liệu nhận được từ server: $resp");

      if (resp != null) {
        List<Review> reviews =
            resp.map<Review>((review) => Review.fromJson(review)).toList();

        // Log: In ra danh sách reviews sau khi chuyển đổi
        // print("Danh sách reviews: $reviews");

        return reviews;
      } else {
        // Log: In thông báo lỗi khi không nhận được dữ liệu
        // print("Không nhận được dữ liệu reviews.");
        throw Exception("Lỗi khi lấy danh sách đánh giá");
      }
    } catch (e) {
      // Log: In lỗi nếu có ngoại lệ xảy ra
      // print("Lỗi khi lấy reviews: $e");
      throw Exception("Lỗi khi lấy danh sách đánh giá");
    }
  }

  Future<Review> addReview(Review review) async {
    final resp = await apiService.addReview(review.toJson());
    if (resp != null) {
      return Review.fromJson(resp);
    } else {
      throw Exception("Lỗi khi thêm đánh giá");
    }
  }
}
