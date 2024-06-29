import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/response/ticket_response.dart';
import 'package:movie_ticker_app_flutter/services/api_service.dart';

class TicketProvider with ChangeNotifier {
  String? _url;
  String? get url => _url;

  List<TicketResponse>? _ticketsByUser;
  List<TicketResponse>? get ticketsByUser => _ticketsByUser;

  List<TicketResponse>? _tickets;
  List<TicketResponse>? get tickets => _tickets;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> submitOrder(
    int orderTotal,
    List<int> seatIds,
    int screeningId,
    int userId,
    int movieId,
  ) async {
    try {
      _url = await ApiService()
          .submitOrder(orderTotal, seatIds, screeningId, userId, movieId);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  Future<void> getAllTicketByUserId(int userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _ticketsByUser = await ApiService().getAllTicketByUserId(userId);
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getAllTicket() async {
    _isLoading = true;
    notifyListeners();
    try {
      _tickets = await ApiService().getAllTicket();
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool checkSeat(int seatId, int screeningId) {
    return _tickets!.any(
      (ticket) {
        return ticket.seats.any(
              (seatTicket) {
                return seatTicket.id == seatId;
              },
            ) &&
            ticket.screening.id == screeningId;
      },
    );
  }

  bool checkSeatByUser(int seatId, int userId) {
    return _tickets!.any((ticket) {
      return ticket.userId == userId &&
          ticket.seats.any(
            (seatTicket) {
              return seatTicket.id == seatId;
            },
          );
    });
  }

  bool checkScreeningEndTime(TicketResponse ticket) {
    DateTime now = DateTime.now();

    String screeningDateStr = ticket.screeningDate;
    String screeningStartTimeStr = ticket.screeningStartTime.substring(0, 5);

    DateTime screeningStartTime =
        DateTime.parse('$screeningDateStr $screeningStartTimeStr');
    DateTime screeningEndTime = screeningStartTime
        .subtract(Duration(minutes: ticket.screening.movie.duration));
    return now.isAfter(screeningEndTime);
  }
}
