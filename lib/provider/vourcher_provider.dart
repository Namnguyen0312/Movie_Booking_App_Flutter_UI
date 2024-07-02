import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/response/vourcher_response.dart';
import 'package:movie_ticker_app_flutter/services/api_service.dart';

class VourcherProvider with ChangeNotifier {
  List<VourcherResponse>? _vourchers;
  List<VourcherResponse>? get vourchers => _vourchers;

  Future<void> getAllVourchers() async {
    try {
      _vourchers = await ApiService().getAllVourchers();
    } catch (e) {
      rethrow;
    }
  }
}
