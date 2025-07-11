import 'package:shoe_store/data/repository/api_service.dart';
import 'package:shoe_store/shared/models/review.dart';

class ReviewRepository {
  ApiService apiService;
  ReviewRepository({required this.apiService});

  Future<List<Review>> getReviews(String productId) async {
    try {
      final resp = await apiService.getReviewProduct(productId);

      if (resp != null) {
        List<Review> reviews =
            resp.map<Review>((review) => Review.fromJson(review)).toList();

        return reviews;
      } else {
        throw Exception("Lỗi khi lấy danh sách đánh giá");
      }
    } catch (e) {
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
