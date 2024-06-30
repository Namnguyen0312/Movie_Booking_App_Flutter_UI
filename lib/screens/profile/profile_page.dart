import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/custom_back_arrow.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/home_page.dart';
import 'package:movie_ticker_app_flutter/screens/profile/edit_profile_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:movie_ticker_app_flutter/utils/animate_right_curve.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        name,
                        style: GoogleFonts.beVietnamPro(
                            textStyle: const TextStyle(
                                fontSize: 24, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        email,
                        style: GoogleFonts.beVietnamPro(
                            textStyle: const TextStyle(
                                fontSize: 12, color: Colors.white60)),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(),
                    GFListTile(
                      avatar: const GFAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                      title: Text(
                        'Chỉnh Sửa Hồ Sơ',
                        style: GoogleFonts.beVietnamPro(
                            textStyle: const TextStyle(
                                fontSize: 14, color: Colors.white)),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          AnimateLeftCurve.createRoute(const EditProfilePage()),
                        );
                      },
                    ),
                    GFListTile(
                      avatar: const GFAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.card_membership, color: Colors.white),
                      ),
                      title: Text(
                        'Thành viên',
                        style: GoogleFonts.beVietnamPro(
                            textStyle: const TextStyle(
                                fontSize: 14, color: Colors.white)),
                      ),
                      onTap: () {},
                    ),
                    GFListTile(
                      avatar: const GFAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.settings, color: Colors.white),
                      ),
                      title: Text(
                        'Cài đặt',
                        style: GoogleFonts.beVietnamPro(
                            textStyle: const TextStyle(
                                fontSize: 14, color: Colors.white)),
                      ),
                      onTap: () {
                        // Navigate to Settings screen
                      },
                    ),
                    GFListTile(
                      avatar: const GFAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.logout, color: Colors.white),
                      ),
                      title: Text(
                        'Đăng xuất',
                        style: GoogleFonts.beVietnamPro(
                            textStyle: const TextStyle(
                                fontSize: 14, color: Colors.white)),
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Bạn đã đăng xuất.'),
                          ),
                        );
                        Provider.of<UserProvider>(context, listen: false)
                            .logoutUser();
                        Navigator.of(context).pushAndRemoveUntil(
                          AnimateRightCurve.createRoute(const HomeScreen()),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
