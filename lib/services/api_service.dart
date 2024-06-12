import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_ticker_app_flutter/models/response/address_response.dart';
import 'package:movie_ticker_app_flutter/models/response/jwt_response.dart';
import 'package:movie_ticker_app_flutter/models/response/cinema_response.dart';
import 'package:movie_ticker_app_flutter/models/request/create_user_request.dart';
import 'package:movie_ticker_app_flutter/models/request/login_user_request.dart';
import 'package:movie_ticker_app_flutter/models/response/movie_response.dart';
import 'package:movie_ticker_app_flutter/models/request/review_request.dart';
import 'package:movie_ticker_app_flutter/models/response/review_response.dart';
import 'package:movie_ticker_app_flutter/models/response/screening_response.dart';
import 'package:movie_ticker_app_flutter/models/response/seat_response.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.56.1:8070';

  //*DELETE
  Future<void> deleteReview(int reviewId, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/review/deleteReview/$reviewId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print('Review delete successfully');
    } else {
      throw Exception('Failed to create review');
    }
  }

  //*PUT
  Future<void> updateReview(
      int reviewId, String token, ReviewRequest review) async {
    final response = await http.put(
      Uri.parse('$baseUrl/review/updateReview/$reviewId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(review.toJson()),
    );
    if (response.statusCode == 200) {
      print('Review updated successfully');
    } else {
      throw Exception('Failed to create review');
    }
  }

  //*POST

  Future<String> submitOrder(
    int orderTotal,
    String seatNumber,
    String movieName,
    String cinema,
    String showTime,
  ) async {
    final response = await http.post(
      Uri.parse(
          '$baseUrl/submitOrder?amount=$orderTotal&seatNumber=$seatNumber&movieName=$movieName&cinema=$cinema&showTime=$showTime'),
    );

    // Kiểm tra mã trạng thái của phản hồi
    if (response.statusCode == 302) {
      // Lấy URL chuyển hướng từ Header Location
      final redirectUrl = response.headers['location'];
      // Gửi yêu cầu mới đến URL đã chuyển hướng
      final newResponse = await http.get(Uri.parse(redirectUrl!));
      // Trả về nội dung của phản hồi mới
      return newResponse.body;
    } else if (response.statusCode == 200) {
      // Nếu không có chuyển hướng, trả về nội dung của phản hồi ban đầu
      return response.body;
    } else {
      // Xử lý lỗi
      throw Exception('Failed to create review');
    }
  }

  Future<void> verifyMail(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forget/verifyMail?email=$email'),
    );
    if (response.statusCode == 200) {
      print('verify email successfully');
    } else {
      throw Exception('Failed to create review');
    }
  }

  Future<void> verifyOtp(int otp, String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forget/verifyOtp?otp=$otp&email=$email'),
    );
    if (response.statusCode == 200) {
      print('verify otp successfully');
    } else {
      throw Exception('Failed to create review');
    }
  }

  Future<void> changePassword(String email, String newPassword) async {
    final response = await http.post(
      Uri.parse(
          '$baseUrl/forget/changePassword?email=$email&newPassword=$newPassword'),
    );
    if (response.statusCode == 200) {
      print('change password successfully');
    } else {
      throw Exception('Failed to create review');
    }
  }

  Future<void> createReview(
      int movieId, int userId, ReviewRequest review, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/review/createReview?movieId=$movieId&userId=$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(review.toJson()),
    );
    if (response.statusCode == 200) {
      print('Review created successfully');
    } else {
      throw Exception('Failed to create review');
    }
  }

  Future<void> createUser(UserCreationRequest user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/createUser'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      print('User created successfully');
    } else {
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
      throw Exception('Failed to login user');
    }
  }

  //*GET

  Future<List<ReviewResponse>> getAllReview(int movieId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/review/get/getById/$movieId'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      final reviews = jsonResponse.map((review) {
        return ReviewResponse.fromJson(review);
      }).toList();
      return reviews;
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Future<List<MovieResponse>> getAllMovie() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/getAll'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      final movies = jsonResponse.map((movie) {
        final movi = MovieResponse.fromJson(movie);
        return movi;
      }).toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<AddressResponse>> getAllAddress() async {
    final response =
        await http.get(Uri.parse('$baseUrl/address/getAddressHasCinema'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse
          .map((address) => AddressResponse.fromJson(address))
          .toList();
    } else {
      throw Exception('Failed to load address');
    }
  }

  Future<List<CinemaResponse>> getCinemasByCity(String city) async {
    final response = await http
        .get(Uri.parse('$baseUrl/cinema/get/getCinemasByCity?city=$city'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse
          .map((cinema) => CinemaResponse.fromJson(cinema))
          .toList();
    } else {
      throw Exception('Failed to load cinemas');
    }
  }

  Future<List<ScreeningResponse>> getScreeningsByCinema(int cinemaId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/screening/getScreeningByCinema?cinemaId=$cinemaId'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse
          .map((screening) => ScreeningResponse.fromJson(screening))
          .toList();
    } else {
      throw Exception('Failed to load screenings');
    }
  }

  Future<List<ScreeningResponse>> getScreeningsByMovieAndCity(
      String city, int movieId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/screening/getScreeningByCityAndMovie?city=$city&movieId=$movieId'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse
          .map((screening) => ScreeningResponse.fromJson(screening))
          .toList();
    } else {
      throw Exception('Failed to load screenings');
    }
  }

  Future<List<SeatResponse>> getAllSeatByAuditorium(int auditoriumId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/seat/getSeatsById/$auditoriumId'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse
          .map((screening) => SeatResponse.fromJson(screening))
          .toList();
    } else {
      throw Exception('Failed to load seat');
    }
  }
}
