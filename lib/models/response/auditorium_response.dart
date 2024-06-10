import 'cinema_response.dart';

class AuditoriumResponse {
  final int id;
  final String name;
  final CinemaResponse cinema;

  AuditoriumResponse({
    required this.id,
    required this.name,
    required this.cinema,
  });

  factory AuditoriumResponse.fromJson(Map<String, dynamic> json) {
    return AuditoriumResponse(
      id: json['id'],
      name: json['name'],
      cinema: CinemaResponse.fromJson(json['cinema']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cinema': cinema.toJson(),
    };
  }
}
