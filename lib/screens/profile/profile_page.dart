import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/arrow_white_back.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:movie_ticker_app_flutter/utils/helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArrowBackWhite(topPadding: kMinPadding),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Avatar
                    const Center(
                      child: GFAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(AssetHelper.imgProfile),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Username
                    Center(
                      child: Text(
                        'John Doe',
                        style: AppStyles.h2,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Email
                    Center(
                      child: Text(
                        'john.doe@example.com',
                        style: AppStyles.h5Light,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Divider
                    const Divider(),

                    // Profile options using GFListTile
                    GFListTile(
                      avatar: const GFAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                      title: const Text('Edit Profile'),
                      onTap: () {
                        // Navigate to Edit Profile screen
                      },
                    ),
                    GFListTile(
                      avatar: const GFAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.settings, color: Colors.white),
                      ),
                      title: const Text('Settings'),
                      onTap: () {
                        // Navigate to Settings screen
                      },
                    ),
                    GFListTile(
                      avatar: const GFAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.logout, color: Colors.white),
                      ),
                      title: const Text('Logout'),
                      onTap: () {
                        // Handle logout
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
