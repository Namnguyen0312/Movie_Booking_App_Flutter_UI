import 'package:movie_ticker_app_flutter/models/request/address_request.dart';

class UserCreationRequest {
  final String name;
  final String email;
  final String phone;
  final String password;
  final AddressRequest address;

  UserCreationRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
  });

  factory UserCreationRequest.fromJson(Map<String, dynamic> json) {
    return UserCreationRequest(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      address: AddressRequest.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'address': address.toJson(),
    };
  }
}
