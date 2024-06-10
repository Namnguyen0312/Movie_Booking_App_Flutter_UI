import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/cinema/select_cinema_page.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/home_page.dart';
import 'package:movie_ticker_app_flutter/screens/login/login_screen.dart';
import 'package:movie_ticker_app_flutter/screens/profile/profile_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    bool isLoggedIn = provider.isLoggedIn;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.grey,
            ),
            child: Text(
              'Đặt Vé Xem\nPhim Online\nMọi Lúc Mọi Nơi',
              style: GoogleFonts.beVietnamPro(
                textStyle: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              'Hồ Sơ',
              style: GoogleFonts.beVietnamPro(
                textStyle:
                    const TextStyle(fontSize: 15, color: AppColors.veryDark),
              ),
            ),
            onTap: () {
              if (!isLoggedIn) {
                context.read<UserProvider>().selectWidget(const HomeScreen());
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              } else {
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: Text(
              'Rạp phim',
              style: GoogleFonts.beVietnamPro(
                textStyle:
                    const TextStyle(fontSize: 15, color: AppColors.veryDark),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                  AnimateLeftCurve.createRoute(const SelectCinemaByCity()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on),
            title: Text(
              'Giá vé',
              style: GoogleFonts.beVietnamPro(
                textStyle:
                    const TextStyle(fontSize: 15, color: AppColors.veryDark),
              ),
            ),
            onTap: () {},
          ),
          if (isLoggedIn)
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(
                'Đăng xuất',
                style: GoogleFonts.beVietnamPro(
                  textStyle:
                      const TextStyle(fontSize: 15, color: AppColors.veryDark),
                ),
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bạn đã đăng xuất.'),
                  ),
                );
                Provider.of<UserProvider>(context, listen: false).logoutUser();
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
    );
  }
}
