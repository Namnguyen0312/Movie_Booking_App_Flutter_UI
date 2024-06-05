import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/seat.dart';
import 'package:movie_ticker_app_flutter/services/api_service.dart';

class SeatProvider with ChangeNotifier {
  List<Seat> _seats = [];
  List<Seat> get seats => _seats;

  List<int> _selectedSeatIds = [];
  List<int> get selectedSeatIds => _selectedSeatIds;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  Future<void> getAllSeatByAuditorium(int auditoriumId) async {
    notifyListeners();
    try {
      final List<Seat> seats =
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

  void toggleSeat(Seat seat) {
    if (_selectedSeatIds.contains(seat.id)) {
      _selectedSeatIds.remove(seat.id);
      _totalPrice -= seat.price;
    } else {
      _selectedSeatIds.add(seat.id);
      _totalPrice += seat.price;
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedSeatIds.clear();
    _totalPrice = 0;
    notifyListeners();
  }

  List<Seat> getSortedSeats() {
    List<Seat> sortedSeats = _seats.toList()
      ..sort((a, b) {
        int rowComparison = a.rowSeat.compareTo(b.rowSeat);
        if (rowComparison != 0) {
          return rowComparison;
        }
        return a.numberSeat.compareTo(b.numberSeat);
      });

    List<String> seatRowLetters =
        sortedSeats.map((seat) => seat.rowSeat).toSet().toList()..sort();

    List<Seat> modifiedSeats = [];
    for (String rowLetter in seatRowLetters) {
      List<Seat> rowSeats =
          sortedSeats.where((seat) => seat.rowSeat == rowLetter).toList();

      if (rowLetter != 'A') {
        int currentNumber = 1;
        rowSeats = rowSeats.map((seat) {
          Seat modifiedSeat = seat.copyWith(numberSeat: currentNumber);
          currentNumber++;
          return modifiedSeat;
        }).toList();
      }

      modifiedSeats.addAll(rowSeats);
    }

    return modifiedSeats;
  }
}
