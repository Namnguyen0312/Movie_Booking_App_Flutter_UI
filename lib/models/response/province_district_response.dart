class ProvinceDistrictResponse {
  String? districtId;
  String? districtName;
  String? districtType;
  dynamic lat;
  dynamic lng;
  String? provinceId;

  ProvinceDistrictResponse({
    this.districtId,
    this.districtName,
    this.districtType,
    this.lat,
    this.lng,
    this.provinceId,
  });

  factory ProvinceDistrictResponse.fromJson(Map<String, dynamic> data) {
    return ProvinceDistrictResponse(
      districtId: data['district_id'] as String?,
      districtName: data['district_name'] as String?,
      districtType: data['district_type'] as String?,
      lat: data['lat'] as dynamic,
      lng: data['lng'] as dynamic,
      provinceId: data['province_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'district_id': districtId,
        'district_name': districtName,
        'district_type': districtType,
        'lat': lat,
        'lng': lng,
        'province_id': provinceId,
      };
}
