class AddressResponse {
  final int id;
  final String city;
  final String district;
  final String street;
  final String ward;

  AddressResponse({
    required this.id,
    required this.city,
    required this.district,
    required this.street,
    required this.ward,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
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
