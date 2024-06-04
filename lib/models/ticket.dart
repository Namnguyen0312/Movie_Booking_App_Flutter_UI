import 'package:movie_ticker_app_flutter/models/screening.dart';
import 'package:movie_ticker_app_flutter/models/seat.dart';
import 'package:movie_ticker_app_flutter/models/user.dart';

class Ticket {
  final int id;
  final int total;
  final String orderTime;
  final int status;
  final PaymentMethod paymentMethod;
  final List<Seat> seats;
  final Screening screening;
  final User user;

  Ticket({
    required this.id,
    required this.total,
    required this.orderTime,
    required this.status,
    required this.paymentMethod,
    required this.seats,
    required this.screening,
    required this.user,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      total: json['total'],
      orderTime: json['order_Time'],
      status: json['status'],
      paymentMethod: PaymentMethodExtension.fromString(json['payment_method']),
      seats: (json['seats'] as List).map((e) => Seat.fromJson(e)).toList(),
      screening: Screening.fromJson(json['screening']),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'order_Time': orderTime,
      'status': status,
      'payment_method': paymentMethod.toShortString(),
      'seats': seats.map((e) => e.toJson()).toList(),
      'screening': screening.toJson(),
      'user': user.toJson(),
    };
  }
}

enum PaymentMethod { momo, vnpay, card }

extension PaymentMethodExtension on PaymentMethod {
  String toShortString() {
    return toString().split('.').last;
  }

  static PaymentMethod fromString(String status) {
    switch (status) {
      case 'momo':
        return PaymentMethod.momo;
      case 'vnpay':
        return PaymentMethod.vnpay;
      case 'card':
        return PaymentMethod.card;
      default:
        throw Exception('Unknown enum value: $status');
    }
  }
}
