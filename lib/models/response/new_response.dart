class NewResponse {
  int? id;
  String? title;
  String? content;
  String? imageUrl;
  DateTime? created;

  NewResponse({
    this.id,
    this.title,
    this.content,
    this.imageUrl,
    this.created,
  });

  factory NewResponse.fromJson(Map<String, dynamic> json) => NewResponse(
        id: json['id'] as int?,
        title: json['title'] as String?,
        content: json['content'] as String?,
        imageUrl: json['imageUrl'] as String?,
        created: json['created'] == null
            ? null
            : DateTime.parse(json['created'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'imageUrl': imageUrl,
        'created': created?.toIso8601String(),
      };
}
