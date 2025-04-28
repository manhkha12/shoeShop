import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoe_store/shared/models/review.dart';

part 'review_state.freezed.dart';
@freezed
class ReviewState with _$ReviewState {
  const factory ReviewState({
    @Default(false) bool isLoading,
    @Default([]) List<Review> reviews,
    @Default("") String errorMessage,
  }) = _ReviewState;
  factory ReviewState.initial() => const ReviewState();
}