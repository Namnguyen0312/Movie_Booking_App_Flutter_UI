import 'package:movie_ticker_app_flutter/models/address.dart';
import 'package:movie_ticker_app_flutter/models/membership.dart';
import 'role_response.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final Address address;
  final Membership membership;
  final Set<RoleResponse> roles;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.membership,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: Address.fromJson(json['address']),
      membership: Membership.fromJson(json['membership']),
      roles: (json['roles'] as List<dynamic>)
          .map((e) => RoleResponse.fromJson(e))
          .toSet(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      // Lưu ý: Không bao gồm trường password trong JSON gửi đi
      'address': address.toJson(),
      'membership': membership.toJson(),
      'roles': roles.map((role) => role.toJson()).toList(),
    };
  }
}
