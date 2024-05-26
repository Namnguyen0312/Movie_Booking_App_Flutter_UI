import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/check_out.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/my_ticket.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/home_page.dart';
import 'package:movie_ticker_app_flutter/screens/login/login_page.dart';
import 'package:movie_ticker_app_flutter/screens/profile/profile_page.dart';
import 'package:movie_ticker_app_flutter/screens/register/register_page.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/select_cinema_page.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/select_seat_page.dart';

import '../screens/movieDetail/movie_detail_page.dart';

final Map<String, WidgetBuilder> routes = {
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  MovieDetailPage.routeName: (context) => const MovieDetailPage(),
  SelectCinemaPage.routeName: (context) => const SelectCinemaPage(),
  SelectSeatPage.routeName: (context) => const SelectSeatPage(),
  CheckOut.routeName: (context) => const CheckOut(),
  MyTicket.routeName: (context) => const MyTicket(),
  LoginPage.routeName: (context) => const LoginPage(),
  RegisterPage.routeName: (context) => const RegisterPage(),
};
