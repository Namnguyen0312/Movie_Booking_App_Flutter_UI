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
      city: json['city'],
      district: json['district'],
      street: json['street'],
      ward: json['ward'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': city,
      'district': district,
      'street': street,
      'ward': ward,
    };
  }
}
