import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/response/ticket_response.dart';
import 'package:movie_ticker_app_flutter/services/api_service.dart';

class TicketProvider with ChangeNotifier {
  String? _url;
  String? get url => _url;

  List<TicketResponse>? _tickets;
  List<TicketResponse>? get tickets => _tickets;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> submitOrder(
    int orderTotal,
    List<int> seatIds,
    int screeningId,
    int userId,
    int movieId,
  ) async {
    try {
      _url = await ApiService()
          .submitOrder(orderTotal, seatIds, screeningId, userId, movieId);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  Future<void> getAllTicketByUserId(int userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _tickets = await ApiService().getAllTicketByUserId(userId);
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
