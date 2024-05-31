import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/datasource/temp_db.dart';
import 'package:movie_ticker_app_flutter/models/seat.dart';

class SeatProvider with ChangeNotifier {
  List<Seat> _seats = [];
  List<Seat> get seats => _seats;

  List<Seat> _selectedSeats = [];
  List<Seat> get selectedSeats => _selectedSeats;
  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getAllSeatByAuditorium(int auditoriumId) async {
    // try {
    //   final List<Seat> seats =
    //       await ApiService().getAllSeatByAuditorium(auditoriumId);
    //   _seats = seats.toList();
    //   notifyListeners();
    // } catch (error) {
    //   rethrow;
    // }

    _isLoading = true;
    notifyListeners();

    _seats = TempDB.tableSeat
        .where((seat) => seat.auditorium.id == auditoriumId)
        .toList();
    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _selectedSeats.clear();
    _seats.clear();
    _isLoading = false;
    notifyListeners();
  }

  void toggleSeat(Seat seat) {
    if (_selectedSeats.contains(seat)) {
      _selectedSeats.remove(seat);
      _totalPrice -= seat.price;
    } else {
      _selectedSeats.add(seat);
      _totalPrice += seat.price;
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedSeats.clear();
    _totalPrice = 0;
    notifyListeners();
  }
}
