import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/custom_back_arrow.dart';
import 'package:movie_ticker_app_flutter/models/response/membership_response.dart';
import 'package:movie_ticker_app_flutter/provider/membership_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/home_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_right_curve.dart';
import 'package:provider/provider.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({super.key});

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  @override
  void initState() {
    super.initState();
    final membershipProvider =
        Provider.of<MembershipProvider>(context, listen: false);
    Future.microtask(() {
      membershipProvider.getAllMembership();
    });
  }

  int _getNextRankPrice(
      String currentRank, List<MembershipResponse> memberships) {
    // Tìm bậc hiện tại và bậc tiếp theo
    for (int i = 0; i < memberships.length; i++) {
      if (memberships[i].name == currentRank) {
        if (i + 1 < memberships.length) {
          return memberships[i + 1].rankprice;
        } else {
          // Nếu không có bậc tiếp theo (bậc cao nhất)
          return memberships[i].rankprice;
        }
      }
    }
    // Nếu không tìm thấy bậc hiện tại, trả về giá trị mặc định
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    final membershipProvider = context.watch<MembershipProvider>();
    final user = userProvider.user;

    int nextRankPrice = _getNextRankPrice(
        user!.membership.name, membershipProvider.memberships!);

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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  AnimateRightCurve.createRoute(const HomeScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(
                Icons.home,
                color: Colors.white60,
              )),
        ],
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
        leading: const CustomBackArrow(),
        elevation: 10,
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Bậc thành viên: ',
                  style: GoogleFonts.beVietnamPro(
                    textStyle: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                _buildMembershipTitle(user.membership.name)
              ],
            ),
            const SizedBox(height: 10),
            _buildMembershipBadge(user.membership.name),
            const SizedBox(height: 20),
            Text(
              'Tiến độ nâng hạng:',
              style: GoogleFonts.beVietnamPro(
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: user.totalprice * 1.0 / nextRankPrice,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.darkBlueIllustration),
            ),
            const SizedBox(height: 10),
            Text(
              '${user.totalprice}/$nextRankPrice',
              style: GoogleFonts.beVietnamPro(
                textStyle: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            Text(
              'Tỉ lệ giảm: ${user.membership.discountRate}%',
              style: GoogleFonts.beVietnamPro(
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembershipTitle(String membershipName) {
    switch (membershipName) {
      case 'Đồng':
        return Text(
          membershipName,
          style: GoogleFonts.beVietnamPro(
            textStyle: const TextStyle(fontSize: 18, color: Colors.brown),
          ),
        );
      case 'Bạc':
        return Text(
          membershipName,
          style: GoogleFonts.beVietnamPro(
            textStyle: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
        );
      case 'Vàng':
        return Text(
          membershipName,
          style: GoogleFonts.beVietnamPro(
            textStyle: const TextStyle(fontSize: 18, color: Colors.amber),
          ),
        );

      default:
        return const Icon(Icons.emoji_events, color: Colors.grey, size: 50);
    }
  }

  Widget _buildMembershipBadge(String membershipName) {
    switch (membershipName) {
      case 'Đồng':
        return const Icon(Icons.emoji_events, color: Colors.brown, size: 50);
      case 'Bạc':
        return const Icon(Icons.emoji_events, color: Colors.grey, size: 50);
      case 'Vàng':
        return const Icon(Icons.emoji_events, color: Colors.amber, size: 50);
      case 'Kim cương':
        return const Icon(Icons.emoji_events, color: Colors.blue, size: 50);
      default:
        return const Icon(Icons.emoji_events, color: Colors.grey, size: 50);
    }
  }
}
