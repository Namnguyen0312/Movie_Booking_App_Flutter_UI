import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/services/api_service.dart';

class VNPayProvider with ChangeNotifier {
  String? _url;
  String? get url => _url;

  Future<void> submitOrder(
    int orderTotal,
    String seatNumber,
    String movieName,
    String cinema,
    String showTime,
  ) async {
    try {
      _url = await ApiService()
          .submitOrder(orderTotal, seatNumber, movieName, cinema, showTime);
      print(_url);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  // Future<int> orderReturn(Map<String, String> queryParams) async {
  //   try {
  //     return await _vnPayService.orderReturn(queryParams);
  //   } catch (e) {
  //     throw Exception('Failed to process payment: $e');
  //   }
  // }
}
