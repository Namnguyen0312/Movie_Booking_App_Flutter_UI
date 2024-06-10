class GenreResponse {
  final int id;
  final String name;

  GenreResponse({
    required this.id,
    required this.name,
  });

  factory GenreResponse.fromJson(Map<String, dynamic> json) {
    return GenreResponse(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
