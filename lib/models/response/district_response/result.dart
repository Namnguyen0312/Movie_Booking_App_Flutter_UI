class Result {
  String? districtId;
  String? districtName;
  String? districtType;
  dynamic lat;
  dynamic lng;
  String? provinceId;

  Result({
    this.districtId,
    this.districtName,
    this.districtType,
    this.lat,
    this.lng,
    this.provinceId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        districtId: json['district_id'] as String?,
        districtName: json['district_name'] as String?,
        districtType: json['district_type'] as String?,
        lat: json['lat'] as dynamic,
        lng: json['lng'] as dynamic,
        provinceId: json['province_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'district_id': districtId,
        'district_name': districtName,
        'district_type': districtType,
        'lat': lat,
        'lng': lng,
        'province_id': provinceId,
      };
}
