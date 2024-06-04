import 'auditorium.dart';

class Seat {
  final int id;
  final int numberSeat;
  final String rowSeat;
  final double price;
  final Auditorium auditorium;

  Seat({
    required this.id,
    required this.numberSeat,
    required this.rowSeat,
    required this.price,
    required this.auditorium,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'],
      numberSeat: json['number_Seat'],
      rowSeat: json['row_Seat'],
      price: json['price'],
      auditorium: Auditorium.fromJson(json['auditorium']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numberSeat': numberSeat,
      'price': price,
      'auditorium': auditorium.toJson(),
    };
  }

  Seat copyWith({
    int? id,
    int? numberSeat,
    String? rowSeat,
    double? price,
  }) {
    return Seat(
      id: id ?? this.id,
      numberSeat: numberSeat ?? this.numberSeat,
      rowSeat: rowSeat ?? this.rowSeat,
      price: price ?? this.price,
      auditorium: auditorium,
    );
  }
}
