import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/response/membership_response.dart';
import 'package:movie_ticker_app_flutter/services/api_service.dart';

class MembershipProvider with ChangeNotifier {
  List<MembershipResponse>? _memberships;
  List<MembershipResponse>? get memberships => _memberships;
  Future<void> getAllMembership() async {
    try {
      _memberships = await ApiService().getAllMembership();
    } catch (e) {
      rethrow;
    }
  }
}
