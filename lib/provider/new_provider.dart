import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/response/new_response.dart';
import 'package:movie_ticker_app_flutter/services/api_service.dart';

class NewProvider extends ChangeNotifier {
  List<NewResponse>? _news = [];
  List<NewResponse>? get news => _news;

  NewResponse? _selectedNew;
  NewResponse? get selectedNew => _selectedNew;

  Future<void> getAllNews() async {
    try {
      _news = await ApiService().getAllNews();
    } catch (e) {
      rethrow;
    }
  }

  void selectNew(NewResponse newfeed) {
    _selectedNew = newfeed;
    notifyListeners();
  }
}
