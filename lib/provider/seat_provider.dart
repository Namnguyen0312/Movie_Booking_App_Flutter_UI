import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/response/seat_response.dart';
import 'package:movie_ticker_app_flutter/services/api_service.dart';

class SeatProvider with ChangeNotifier {
  List<SeatResponse> _seats = [];
  List<SeatResponse> get seats => _seats;

  List<int> _selectedSeatIds = [];
  List<int> get selectedSeatIds => _selectedSeatIds;

  double _totalPrice = 0;
  double get totalPrice => _totalPrice;

  Future<void> getAllSeatByAuditorium(int auditoriumId) async {
    notifyListeners();
    try {
      final List<SeatResponse> seats =
          await ApiService().getAllSeatByAuditorium(auditoriumId);
      _seats = seats;
      notifyListeners();
    } catch (error) {
      notifyListeners();
      rethrow;
    }
  }

  void reset() {
    _selectedSeatIds.clear();
    _seats.clear();
    _totalPrice = 0;
    notifyListeners();
  }

  void toggleSeat(SeatResponse seat) {
    if (_selectedSeatIds.contains(seat.id)) {
      if (seat.seatType == 'sweetBox') {
        _selectedSeatIds.remove(seat.id);
        seat.numberSeat.isEven
            ? _selectedSeatIds.remove(seat.id - 1)
            : _selectedSeatIds.remove(seat.id + 1);
        _totalPrice -= seat.price * 2;
      } else {
        _selectedSeatIds.remove(seat.id);
        _totalPrice -= seat.price;
      }
    } else {
      if (seat.seatType == 'sweetBox') {
        _selectedSeatIds.add(seat.id);
        seat.numberSeat.isEven
            ? _selectedSeatIds.add(seat.id - 1)
            : _selectedSeatIds.add(seat.id + 1);
        _totalPrice += seat.price * 2;
      } else {
        _selectedSeatIds.add(seat.id);
        _totalPrice += seat.price;
      }
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedSeatIds.clear();
    _totalPrice = 0;
    notifyListeners();
  }

  List<SeatResponse> getSortedSeats(List<SeatResponse> seats) {
    List<SeatResponse> sortedSeats = seats
      ..sort((a, b) {
        int rowComparison = a.rowSeat.compareTo(b.rowSeat);
        if (rowComparison != 0) {
          return rowComparison;
        }
        return a.numberSeat.compareTo(b.numberSeat);
      });

    Map<String, int> rowNumberMap = {};

    List<SeatResponse> modifiedSeats = [];
    for (SeatResponse seat in sortedSeats) {
      if (!rowNumberMap.containsKey(seat.rowSeat)) {
        rowNumberMap[seat.rowSeat] = 1;
      }

      // Assign numberSeat based on its original numberSeat value
      SeatResponse modifiedSeat = seat.copyWith(numberSeat: seat.numberSeat);
      modifiedSeats.add(modifiedSeat);

      rowNumberMap[seat.rowSeat] = rowNumberMap[seat.rowSeat]! + 1;
    }

    return modifiedSeats;
  }
}
