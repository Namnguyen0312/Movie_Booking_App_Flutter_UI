import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/screens/profile/profile_page.dart';

import '../../../themes/app_styles.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kTop32Padding,
        left: kMediumPadding,
        right: kMediumPadding,
      ),
      child: SizedBox(
        height: size.height / 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Find Your Best\nMovie",
              style: AppStyles.h1,
            ),
            GestureDetector(
              // onTap: () {
              //   Navigator.of(context)
              //       .pushNamed(ProfileScreen.routeName, arguments: userName);
              // },
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ProfileScreen.routeName);
                },
                child: CircleAvatar(
                  radius: size.height / 24,
                  backgroundImage: const AssetImage(AssetHelper.imgProfile),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
