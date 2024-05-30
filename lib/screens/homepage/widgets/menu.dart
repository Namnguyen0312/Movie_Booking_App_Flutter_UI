import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/screens/cinema/select_cinema_page.dart';
import 'package:movie_ticker_app_flutter/screens/login/login_screen.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:movie_ticker_app_flutter/utils/animate.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              style: AppStyles.h2,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Hồ Sơ'),
            onTap: () {
              Navigator.of(context).pushNamed(LoginScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Rạp phim'),
            onTap: () {
              Navigator.of(context)
                  .push(Animate.createRoute(const SelectCinemaByCity()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on),
            title: const Text('Giá vé'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
