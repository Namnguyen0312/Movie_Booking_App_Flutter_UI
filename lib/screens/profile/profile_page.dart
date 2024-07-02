import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/custom_back_arrow.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/profile/widgets/menu_profile_widget.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    String name = '';
    String email = '';
    if (userProvider.isLoggedIn) {
      name = userProvider.user!.name;
      email = userProvider.user!.email;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Hồ sơ',
          style: GoogleFonts.beVietnamPro(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
        leading: const CustomBackArrow(),
        elevation: 10,
        shadowColor: Colors.black,
      ),
      body: MenuProfileWidget(name: name, email: email),
    );
  }
}
