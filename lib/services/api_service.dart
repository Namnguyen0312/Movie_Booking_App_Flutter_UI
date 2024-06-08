import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_ticker_app_flutter/models/address.dart';
import 'package:movie_ticker_app_flutter/models/jwt_response.dart';
import 'package:movie_ticker_app_flutter/models/cinema.dart';
import 'package:movie_ticker_app_flutter/models/create_user.dart';
import 'package:movie_ticker_app_flutter/models/login_user.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';
import 'package:movie_ticker_app_flutter/models/seat.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.56.1:8070';

  Future<void> createUser(UserCreationRequest user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/createUser'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      // Handle success response
      print('User created successfully');
    } else {
      // Handle error response
      throw Exception('Failed to create user');
    }
  }

  Future<JwtResponse> loginUser(UserLoginRequest user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/userLogin'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      return JwtResponse.fromJson(responseData);
    } else {
      // Handle error response
      throw Exception('Failed to login user');
    }
  }

  Future<List<Movie>> getAllMovie() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/getAll'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      final movies = jsonResponse.map((movie) {
        final movi = Movie.fromJson(movie);
        return movi;
      }).toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Address>> getAllAddress() async {
    final response =
        await http.get(Uri.parse('$baseUrl/address/getAddressHasCinema'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((address) => Address.fromJson(address)).toList();
    } else {
      throw Exception('Failed to load address');
    }
  }

  Future<List<Cinema>> getCinemasByCity(String city) async {
    final response = await http
        .get(Uri.parse('$baseUrl/cinema/get/getCinemasByCity?city=$city'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((cinema) => Cinema.fromJson(cinema)).toList();
    } else {
      throw Exception('Failed to load cinemas');
    }
  }

  Future<List<Screening>> getScreeningsByCinema(int cinemaId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/screening/getScreeningByCinema?cinemaId=$cinemaId'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse
          .map((screening) => Screening.fromJson(screening))
          .toList();
    } else {
      throw Exception('Failed to load screenings');
    }
  }

  Future<List<Screening>> getScreeningsByMovieAndCity(
      String city, int movieId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/screening/getScreeningByCityAndMovie?city=$city&movieId=$movieId'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse
          .map((screening) => Screening.fromJson(screening))
          .toList();
    } else {
      throw Exception('Failed to load screenings');
    }
  }

  Future<List<Seat>> getAllSeatByAuditorium(int auditoriumId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/seat/getSeatsById/$auditoriumId'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((screening) => Seat.fromJson(screening)).toList();
    } else {
      throw Exception('Failed to load seat');
    }
  }
}
