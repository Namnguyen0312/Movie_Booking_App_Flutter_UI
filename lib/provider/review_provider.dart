import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/request/review_request.dart';
import 'package:movie_ticker_app_flutter/models/response/review_response.dart';
import 'package:movie_ticker_app_flutter/services/api_service.dart';

class ReviewProvider with ChangeNotifier {
  List<ReviewResponse>? _reviews;
  List<ReviewResponse>? get reviews => _reviews;

  Future<void> getAllReivewByMovieId(int movieId) async {
    try {
      _reviews = await ApiService().getAllReview(movieId);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createReview(
      int movieId, int userId, ReviewRequest review, String token) async {
    try {
      await ApiService().createReview(movieId, userId, review, token);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateReview(
      int reviewId, ReviewRequest review, String token) async {
    try {
      await ApiService().updateReview(reviewId, token, review);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteReview(int reviewId, String token) async {
    try {
      await ApiService().deleteReview(reviewId, token);
    } catch (error) {
      rethrow;
    }
  }
}
