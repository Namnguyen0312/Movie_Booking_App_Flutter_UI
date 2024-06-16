class Result {
  String? provinceId;
  String? provinceName;
  String? provinceType;

  Result({this.provinceId, this.provinceName, this.provinceType});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        provinceId: json['province_id'] as String?,
        provinceName: json['province_name'] as String?,
        provinceType: json['province_type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'province_id': provinceId,
        'province_name': provinceName,
        'province_type': provinceType,
      };
}
