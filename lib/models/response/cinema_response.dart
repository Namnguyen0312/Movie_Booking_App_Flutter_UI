import 'address_response.dart';

class CinemaResponse {
  final int id;
  final AddressResponse address;
  final String name;

  CinemaResponse({
    required this.id,
    required this.address,
    required this.name,
  });

  factory CinemaResponse.fromJson(Map<String, dynamic> json) {
    return CinemaResponse(
      id: json['id'],
      address: AddressResponse.fromJson(json['address']),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address.toJson(),
      'name': name,
    };
  }
}
