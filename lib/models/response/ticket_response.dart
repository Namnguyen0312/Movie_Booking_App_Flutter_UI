import 'package:movie_ticker_app_flutter/models/response/screening_response.dart';
import 'package:movie_ticker_app_flutter/models/response/seat_response.dart';
import 'package:movie_ticker_app_flutter/models/response/user_response.dart';

class TicketResponse {
  final int id;
  final int total;
  final String orderTime;
  final int status;
  final PaymentMethod paymentMethod;
  final List<SeatResponse> seats;
  final ScreeningResponse screening;
  final UserResponse user;

  TicketResponse({
    required this.id,
    required this.total,
    required this.orderTime,
    required this.status,
    required this.paymentMethod,
    required this.seats,
    required this.screening,
    required this.user,
  });

  factory TicketResponse.fromJson(Map<String, dynamic> json) {
    return TicketResponse(
      id: json['id'],
      total: json['total'],
      orderTime: json['order_Time'],
      status: json['status'],
      paymentMethod: PaymentMethodExtension.fromString(json['payment_method']),
      seats:
          (json['seats'] as List).map((e) => SeatResponse.fromJson(e)).toList(),
      screening: ScreeningResponse.fromJson(json['screening']),
      user: UserResponse.fromJson(json['user']),
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
