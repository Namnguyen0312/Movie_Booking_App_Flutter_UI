import 'package:movie_ticker_app_flutter/models/response/screening_response.dart';
import 'package:movie_ticker_app_flutter/models/response/seat_response.dart';
import 'package:movie_ticker_app_flutter/models/response/vourcher_response.dart';

class TicketResponse {
  final String userName;
  final String movieTitle;
  final String qrcode;
  final String screeningDate;
  final String screeningStartTime;
  final String auditoriumName;
  final int total;
  final List<SeatResponse> seats;
  final ScreeningResponse screening;
  final String orderTime;
  final int userId;
  final VourcherResponse vourcher;

  TicketResponse({
    required this.userName,
    required this.movieTitle,
    required this.qrcode,
    required this.screeningDate,
    required this.screeningStartTime,
    required this.auditoriumName,
    required this.total,
    required this.seats,
    required this.screening,
    required this.orderTime,
    required this.userId,
    required this.vourcher,
  });

  factory TicketResponse.fromJson(Map<String, dynamic> json) {
    return TicketResponse(
        userName: json['userName'],
        movieTitle: json['movieTitle'],
        qrcode: json['qrcode'],
        screeningDate: json['screeningDate'],
        screeningStartTime: json['screeningStartTime'],
        auditoriumName: json['auditoriumName'],
        total: json['total'],
        seats: (json['seats'] as List)
            .map((e) => SeatResponse.fromJson(e))
            .toList(),
        screening: ScreeningResponse.fromJson(json['screening']),
        orderTime: json['orderTime'],
        userId: json['userid'],
        vourcher: VourcherResponse.fromJson(json['vourcher']));
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'movieTitle': movieTitle,
      'qrcode': qrcode,
      'screeningDate': screeningDate,
      'screeningStartTime': screeningStartTime,
      'auditoriumName': auditoriumName,
      'total': total,
      'seats': seats.map((e) => e.toJson()).toList(),
      'screening': screening.toJson(),
      'orderTime': orderTime,
      'userid': userId,
      'vourcher': vourcher.toJson(),
    };
  }
}

// class TicketResponse {
//   final int id;
//   final int total;
//   final String orderTime;
//   final int status;
//   final PaymentMethod paymentMethod;
//   final List<SeatResponse> seats;
//   final ScreeningResponse screening;
//   final UserResponse user;

//   TicketResponse({
//     required this.id,
//     required this.total,
//     required this.orderTime,
//     required this.status,
//     required this.paymentMethod,
//     required this.seats,
//     required this.screening,
//     required this.user,
//   });

//   factory TicketResponse.fromJson(Map<String, dynamic> json) {
//     return TicketResponse(
//       id: json['id'],
//       total: json['total'],
//       orderTime: json['order_Time'],
//       status: json['status'],
//       paymentMethod: PaymentMethodExtension.fromString(json['payment_method']),
//       seats:
//           (json['seats'] as List).map((e) => SeatResponse.fromJson(e)).toList(),
//       screening: ScreeningResponse.fromJson(json['screening']),
//       user: UserResponse.fromJson(json['user']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'total': total,
//       'order_Time': orderTime,
//       'status': status,
//       'payment_method': paymentMethod.toShortString(),
//       'seats': seats.map((e) => e.toJson()).toList(),
//       'screening': screening.toJson(),
//       'user': user.toJson(),
//     };
//   }
// }

// enum PaymentMethod { momo, vnpay, card }

// extension PaymentMethodExtension on PaymentMethod {
//   String toShortString() {
//     return toString().split('.').last;
//   }

//   static PaymentMethod fromString(String status) {
//     switch (status) {
//       case 'momo':
//         return PaymentMethod.momo;
//       case 'vnpay':
//         return PaymentMethod.vnpay;
//       case 'card':
//         return PaymentMethod.card;
//       default:
//         throw Exception('Unknown enum value: $status');
//     }
//   }
// }
