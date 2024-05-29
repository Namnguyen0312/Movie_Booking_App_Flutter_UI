import 'address.dart';

class Cinema {
  final int id;
  final Address address;
  final String name;

  Cinema({
    required this.id,
    required this.address,
    required this.name,
  });

  factory Cinema.fromJson(Map<String, dynamic> json) {
    return Cinema(
      id: json['id'],
      address: Address.fromJson(json['address']),
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
