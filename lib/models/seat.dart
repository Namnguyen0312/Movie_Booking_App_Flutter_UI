import 'auditorium.dart';

class Seat {
  final int id;
  final String numberSeat;
  final int price;
  final SeatStatus status;
  final Auditorium auditorium;

  Seat({
    required this.id,
    required this.numberSeat,
    required this.price,
    required this.status,
    required this.auditorium,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'],
      numberSeat: json['numberSeat'],
      price: json['price'],
      status: SeatStatusExtension.fromString(json['status']),
      auditorium: Auditorium.fromJson(json['auditorium']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numberSeat': numberSeat,
      'price': price,
      'status': status.toShortString(),
      'auditorium': auditorium.toJson(),
    };
  }
}

enum SeatStatus { available, reserved, sold }

extension SeatStatusExtension on SeatStatus {
  String toShortString() {
    return toString().split('.').last;
  }

  static SeatStatus fromString(String status) {
    switch (status) {
      case 'available':
        return SeatStatus.available;
      case 'reserved':
        return SeatStatus.reserved;
      case 'sold':
        return SeatStatus.sold;
      default:
        throw Exception('Unknown enum value: $status');
    }
  }
}
