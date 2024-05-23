import 'package:movie_ticker_app_flutter/models/address.dart';

class Cinema {
  final int id;
  final Address address;
  final String name;

  Cinema({
    required this.id,
    required this.address,
    required this.name,
  });
}
