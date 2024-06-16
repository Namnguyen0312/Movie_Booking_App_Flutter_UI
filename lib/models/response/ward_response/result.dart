class Result {
  String? districtId;
  String? wardId;
  String? wardName;
  String? wardType;

  Result({this.districtId, this.wardId, this.wardName, this.wardType});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        districtId: json['district_id'] as String?,
        wardId: json['ward_id'] as String?,
        wardName: json['ward_name'] as String?,
        wardType: json['ward_type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'district_id': districtId,
        'ward_id': wardId,
        'ward_name': wardName,
        'ward_type': wardType,
      };
}
