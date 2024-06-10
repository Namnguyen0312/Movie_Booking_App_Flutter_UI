import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/review_provider.dart';
import 'package:movie_ticker_app_flutter/provider/seat_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';

import 'package:movie_ticker_app_flutter/screens/homepage/home_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:provider/provider.dart';

import 'routes/routes.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AppProvider(),
          ),
          ChangeNotifierProvider(create: (context) => SeatProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => ReviewProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: FontFamily.mont,
            scaffoldBackgroundColor: DarkTheme.darkerBackground,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: AppColors.white,
                  displayColor: AppColors.white,
                ),
          ),
          routes: routes,
          home: const HomeScreen(),
        ));
  }
}
