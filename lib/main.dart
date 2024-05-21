import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/screens/home/home_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';

import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.deepPurple,
    //   statusBarBrightness: Brightness.dark,
    // ));
    return MaterialApp(
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
    );
  }
}
