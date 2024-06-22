import 'auditorium_response.dart';

class SeatResponse {
  final int id;
  final int numberSeat;
  final String rowSeat;
  final double price;
  final AuditoriumResponse auditorium;
  final int seatStatus;
  final String seatType;

  SeatResponse({
    required this.id,
    required this.numberSeat,
    required this.rowSeat,
    required this.price,
    required this.auditorium,
    required this.seatStatus,
    required this.seatType,
  });

  factory SeatResponse.fromJson(Map<String, dynamic> json) {
    return SeatResponse(
      id: json['id'],
      numberSeat: json['number_Seat'],
      rowSeat: json['row_Seat'],
      price: json['price'],
      auditorium: AuditoriumResponse.fromJson(json['auditorium']),
      seatStatus: json['seatstatus'],
      seatType: json['seatType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number_Seat': numberSeat,
      'row_Seat': rowSeat,
      'price': price,
      'auditorium': auditorium.toJson(),
      'seatstatus': seatStatus,
      'seatType': seatType,
    };
  }

  SeatResponse copyWith({
    int? id,
    int? numberSeat,
    String? rowSeat,
    double? price,
    int? seatStatus,
    String? seatType,
  }) {
    return SeatResponse(
      id: id ?? this.id,
      numberSeat: numberSeat ?? this.numberSeat,
      rowSeat: rowSeat ?? this.rowSeat,
      price: price ?? this.price,
      auditorium: auditorium,
      seatStatus: seatStatus ?? this.seatStatus,
      seatType: seatType ?? this.seatType,
    );
  }
}

enum SeatType { normal, vip, sweetBox }
