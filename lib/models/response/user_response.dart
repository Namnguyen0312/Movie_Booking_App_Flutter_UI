import 'package:movie_ticker_app_flutter/models/response/address_response.dart';
import 'package:movie_ticker_app_flutter/models/response/membership_response.dart';
import 'role_response.dart';

class UserResponse {
  final int id;
  final String name;
  final String email;
  final String phone;
  final AddressResponse address;
  final MembershipResponse membership;
  final Set<RoleResponse> roles;

  UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.membership,
    required this.roles,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: AddressResponse.fromJson(json['address']),
      membership: MembershipResponse.fromJson(json['membership']),
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
