class TicketResponse {
  final String userName;
  final int movieId;
  final String movieTitle;
  final String? qrcode;
  final int screeningId;
  final String screeningDate;
  final String screeningStartTime;
  final int auditoriumId;
  final String auditoriumName;
  final int total;
  final String rowSeat;
  final int numberSeat;

  TicketResponse({
    required this.userName,
    required this.movieId,
    required this.movieTitle,
    required this.qrcode,
    required this.screeningId,
    required this.screeningDate,
    required this.screeningStartTime,
    required this.auditoriumId,
    required this.auditoriumName,
    required this.total,
    required this.rowSeat,
    required this.numberSeat,
  });

  factory TicketResponse.fromJson(Map<String, dynamic> json) {
    return TicketResponse(
      userName: json['userName'],
      movieId: json['movieId'],
      movieTitle: json['movieTitle'],
      qrcode: json['qrcode'],
      screeningId: json['screeningId'],
      screeningDate: json['screeningDate'],
      screeningStartTime: json['screeningStartTime'],
      auditoriumId: json['auditoriumId'],
      auditoriumName: json['auditoriumName'],
      total: json['total'],
      rowSeat: json['rowSeat'],
      numberSeat: json['numberSeat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'movieId': movieId,
      'movieTitle': movieTitle,
      'qrcode': qrcode,
      'screeningId': screeningId,
      'screeningDate': screeningDate,
      'screeningStartTime': screeningStartTime,
      'auditoriumId': auditoriumId,
      'auditoriumName': auditoriumName,
      'total': total,
      'rowSeat': rowSeat,
      'numberSeat': numberSeat,
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
