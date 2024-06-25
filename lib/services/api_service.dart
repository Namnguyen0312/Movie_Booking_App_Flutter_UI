import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_ticker_app_flutter/models/response/address_response.dart';
import 'package:movie_ticker_app_flutter/models/response/jwt_response.dart';
import 'package:movie_ticker_app_flutter/models/response/cinema_response.dart';
import 'package:movie_ticker_app_flutter/models/request/create_user_request.dart';
import 'package:movie_ticker_app_flutter/models/request/login_user_request.dart';
import 'package:movie_ticker_app_flutter/models/response/movie_response.dart';
import 'package:movie_ticker_app_flutter/models/request/review_request.dart';
import 'package:movie_ticker_app_flutter/models/response/new_response.dart';
import 'package:movie_ticker_app_flutter/models/response/province_district_response.dart';
import 'package:movie_ticker_app_flutter/models/response/province_response.dart';
import 'package:movie_ticker_app_flutter/models/response/province_ward_response.dart';

import 'package:movie_ticker_app_flutter/models/response/review_response.dart';
import 'package:movie_ticker_app_flutter/models/response/screening_response.dart';
import 'package:movie_ticker_app_flutter/models/response/seat_response.dart';
import 'package:movie_ticker_app_flutter/models/response/ticket_response.dart';

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
    List<int> seatIds,
    int screeningId,
    int userId,
    int movieId,
  ) async {
    final url = Uri.parse('$baseUrl/submitOrder');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'amount': orderTotal.toString(),
        'seatIds': seatIds.join(','),
        'screeningId': screeningId.toString(),
        'userId': userId.toString(),
        'movieId': movieId.toString(),
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to submit order: ${response.reasonPhrase}');
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

  Future<List<NewResponse>> getAllNews() async {
    final response = await http.get(Uri.parse('$baseUrl/new/getAll'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      final news = jsonResponse.map((newFeed) {
        return NewResponse.fromJson(newFeed);
      }).toList();
      return news;
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<ProvinceResponse>> getAllProvince() async {
    final response =
        await http.get(Uri.parse('https://vapi.vnappmob.com/api/province'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse =
          json.decode(utf8.decode(response.bodyBytes));
      final List<dynamic> results = jsonResponse['results'];

      final provinces = results.map((province) {
        return ProvinceResponse.fromJson(province);
      }).toList();

      return provinces;
    } else {
      throw Exception('Failed to load provinces');
    }
  }

  Future<List<ProvinceDistrictResponse>> getAllDistrictByProvinceId(
      String provinceId) async {
    final response = await http.get(Uri.parse(
        'https://vapi.vnappmob.com/api/province/district/$provinceId'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse =
          json.decode(utf8.decode(response.bodyBytes));
      final List<dynamic> results = jsonResponse['results'];
      final districts = results.map((district) {
        return ProvinceDistrictResponse.fromJson(district);
      }).toList();
      return districts;
    } else {
      throw Exception('Failed to load district');
    }
  }

  Future<List<ProvinceWardResponse>> getAllWardByDistrictId(
      String districtId) async {
    final response = await http.get(
        Uri.parse('https://vapi.vnappmob.com/api/province/ward/$districtId'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse =
          json.decode(utf8.decode(response.bodyBytes));
      final List<dynamic> results = jsonResponse['results'];
      final wards = results.map((ward) {
        return ProvinceWardResponse.fromJson(ward);
      }).toList();
      return wards;
    } else {
      throw Exception('Failed to load ward');
    }
  }

  Future<List<TicketResponse>> getAllTicketByUserId(int userId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/TicketbyUserID/$userId'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      final tickets = jsonResponse.map((ticket) {
        return TicketResponse.fromJson(ticket);
      }).toList();
      return tickets;
    } else {
      throw Exception('Failed to load tickets');
    }
  }

  Future<List<TicketResponse>> getAllTicket() async {
    final response = await http.get(Uri.parse('$baseUrl/tickets/GetAll'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      final tickets = jsonResponse.map((ticket) {
        return TicketResponse.fromJson(ticket);
      }).toList();
      return tickets;
    } else {
      throw Exception('Failed to load tickets');
    }
  }

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
