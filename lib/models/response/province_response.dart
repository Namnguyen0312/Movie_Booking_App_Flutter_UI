class ProvinceResponse {
  String? provinceId;
  String? provinceName;
  String? provinceType;

  ProvinceResponse({this.provinceId, this.provinceName, this.provinceType});

  factory ProvinceResponse.fromJson(Map<String, dynamic> data) {
    return ProvinceResponse(
      provinceId: data['province_id'] as String?,
      provinceName: data['province_name'] as String?,
      provinceType: data['province_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'province_id': provinceId,
        'province_name': provinceName,
        'province_type': provinceType,
      };
}
