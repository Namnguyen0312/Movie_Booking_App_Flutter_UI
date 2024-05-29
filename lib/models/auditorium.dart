import 'cinema.dart';

class Auditorium {
  final int id;
  final String name;
  final Cinema cinema;

  Auditorium({
    required this.id,
    required this.name,
    required this.cinema,
  });

  factory Auditorium.fromJson(Map<String, dynamic> json) {
    return Auditorium(
      id: json['id'],
      name: json['name'],
      cinema: Cinema.fromJson(json['cinema']),
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
