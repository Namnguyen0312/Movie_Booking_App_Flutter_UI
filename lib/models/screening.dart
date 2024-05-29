import 'auditorium.dart';

class Screening {
  final int id;
  final String start;
  final String date;
  final Auditorium auditorium;

  Screening({
    required this.id,
    required this.start,
    required this.date,
    required this.auditorium,
  });

  factory Screening.fromJson(Map<String, dynamic> json) {
    return Screening(
      id: json['id'],
      start: json['start'],
      date: json['date'],
      auditorium: Auditorium.fromJson(json['auditorium']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start': start,
      'date': date,
      'auditorium': auditorium.toJson(),
    };
  }
}
