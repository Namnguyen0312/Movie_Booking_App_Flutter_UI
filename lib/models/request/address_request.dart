class AddressRequest {
  final String city;
  final String district;
  final String street;
  final String ward;

  AddressRequest({
    required this.city,
    required this.district,
    required this.street,
    required this.ward,
  });

  factory AddressRequest.fromJson(Map<String, dynamic> json) {
    return AddressRequest(
      city: json['city'],
      district: json['district'],
      street: json['street'],
      ward: json['ward'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'ward': ward,
      'district': district,
      'city': city,
    };
  }
}
