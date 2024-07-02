import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/home_page.dart';
import 'package:movie_ticker_app_flutter/screens/membership/membership_page.dart';
import 'package:movie_ticker_app_flutter/screens/profile/edit_profile_page.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:movie_ticker_app_flutter/utils/animate_right_curve.dart';
import 'package:provider/provider.dart';

class MenuProfileWidget extends StatelessWidget {
  const MenuProfileWidget({
    super.key,
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    onTap: () {
                      Navigator.of(context).push(
                        AnimateLeftCurve.createRoute(const MembershipPage()),
                      );
                    },
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
    );
  }
}
