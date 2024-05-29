import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_ticker_app_flutter/models/address.dart';
import 'package:movie_ticker_app_flutter/models/cinema.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';

class ApiService {
  static const String baseUrl = 'http://yourapiurl.com';

  Future<List<Movie>> getAllMovie() async {
    final response = await http.get(Uri.parse('$baseUrl/movies'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load address');
    }
  }

  Future<List<Address>> getAllAddress() async {
    final response = await http.get(Uri.parse('$baseUrl/address'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((address) => Address.fromJson(address)).toList();
    } else {
      throw Exception('Failed to load address');
    }
  }

  Future<List<Cinema>> getCinemasByCity(String city) async {
    final response = await http.get(Uri.parse('$baseUrl/cinemas?city=$city'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((cinema) => Cinema.fromJson(cinema)).toList();
    } else {
      throw Exception('Failed to load cinemas');
    }
  }

  Future<List<Movie>> getMoviesByCinema(int cinemaId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/cinemas/$cinemaId/movies'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Screening>> getScreeningsByMovie(
      int cinemaId, int movieId) async {
    final response = await http.get(
        Uri.parse('$baseUrl/cinemas/$cinemaId/movies/$movieId/screenings'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((screening) => Screening.fromJson(screening))
          .toList();
    } else {
      throw Exception('Failed to load screenings');
    }
  }

  Future<List<Screening>> getScreeningsByMovieAndCity(
      String city, int movieId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/address/$city/movies/$movieId/screenings'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((screening) => Screening.fromJson(screening))
          .toList();
    } else {
      throw Exception('Failed to load screenings');
    }
  }
}
