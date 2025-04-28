import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';
import 'package:shoe_store/data/repository/review_repository.dart';
import 'package:shoe_store/shared/cubits/review_cubit/review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewRepository reviewRepository;
  ReviewCubit({required this.reviewRepository}) : super(ReviewState());

  Future<void> loadReviews(String productId) async {
    emit(state.copyWith(isLoading: true));
    try {
      final reviews = await reviewRepository.getReviews(productId);
      emit(state.copyWith(reviews: reviews, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}
