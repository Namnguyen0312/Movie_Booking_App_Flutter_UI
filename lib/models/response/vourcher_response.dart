class VourcherResponse {
  int? id;
  DateTime? startDateTime;
  DateTime? endDateTime;
  int? number;
  double? discount;
  String? content;

  VourcherResponse({
    this.id,
    this.startDateTime,
    this.endDateTime,
    this.number,
    this.discount,
    this.content,
  });

  factory VourcherResponse.fromJson(Map<String, dynamic> json) {
    return VourcherResponse(
      id: json['id'] as int?,
      startDateTime: json['startDateTime'] == null
          ? null
          : DateTime.parse(json['startDateTime'] as String),
      endDateTime: json['endDateTime'] == null
          ? null
          : DateTime.parse(json['endDateTime'] as String),
      number: json['number'] as int?,
      discount: (json['discount'] as num?)?.toDouble(),
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'startDateTime': startDateTime?.toIso8601String(),
        'endDateTime': endDateTime?.toIso8601String(),
        'number': number,
        'discount': discount,
        'content': content,
      };
}
