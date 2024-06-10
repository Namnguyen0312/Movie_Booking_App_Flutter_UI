import 'auditorium_response.dart';

class SeatResponse {
  final int id;
  final int numberSeat;
  final String rowSeat;
  final double price;
  final AuditoriumResponse auditorium;

  SeatResponse({
    required this.id,
    required this.numberSeat,
    required this.rowSeat,
    required this.price,
    required this.auditorium,
  });

  factory SeatResponse.fromJson(Map<String, dynamic> json) {
    return SeatResponse(
      id: json['id'],
      numberSeat: json['number_Seat'],
      rowSeat: json['row_Seat'],
      price: json['price'],
      auditorium: AuditoriumResponse.fromJson(json['auditorium']),
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

  SeatResponse copyWith({
    int? id,
    int? numberSeat,
    String? rowSeat,
    double? price,
  }) {
    return SeatResponse(
      id: id ?? this.id,
      numberSeat: numberSeat ?? this.numberSeat,
      rowSeat: rowSeat ?? this.rowSeat,
      price: price ?? this.price,
      auditorium: auditorium,
    );
  }
}
