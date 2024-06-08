class Address {
  final int id;
  final String city;
  final String district;
  final String street;
  final String ward;

  Address({
    required this.id,
    required this.city,
    required this.district,
    required this.street,
    required this.ward,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      street: json['street'],
      ward: json['ward'],
      district: json['district'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'street': street,
      'ward': ward,
      'district': district,
      'city': city,
    };
  }
}
