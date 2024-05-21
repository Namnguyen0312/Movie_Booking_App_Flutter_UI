import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/arrow_white_back.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/check_out.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/built_seat_status_bar.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/movie_title.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/toggle_button.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:movie_ticker_app_flutter/utils/helper.dart';

import '../../models/movie.dart';

class SelectSeatPage extends StatefulWidget {
  const SelectSeatPage({super.key});

  static const String routeName = '/select_seat_page';

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  @override
  Widget build(BuildContext context) {
    Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArrowBackWhite(topPadding: kMinPadding),
            MovieTitle(nameMovie: movie.name.toString()),
            const Padding(
              padding: EdgeInsets.only(top: kDefaultIconSize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BuiltSeatStatusBar(
                      color: AppColors.darkBackground, status: 'Có sẵn'),
                  BuiltSeatStatusBar(
                      color: AppColors.greyBackground, status: 'Đã hết'),
                  BuiltSeatStatusBar(
                      color: AppColors.blueMain, status: 'Ghế của bạn'),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultIconSize,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: seatRow
                      .map(
                        (sRow) => Builder(
                          builder: (context) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: seatNumber.asMap().entries.map(
                                (entry) {
                                  final sNum = entry.value;
                                  final index = entry.key;

                                  if (index == 2) {
                                    return ToggleButton(
                                      margin: 30,
                                      child: Text(sRow + sNum),
                                    );
                                  } else {
                                    return ToggleButton(
                                        child: Text(sRow + sNum));
                                  }
                                },
                              ).toList(),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Screen',
                style: AppStyles.h5.copyWith(color: AppColors.grey),
              ),
            ),
            Center(child: Image.asset(AssetHelper.imgSeat)),
            Padding(
              padding: const EdgeInsets.only(
                left: kDefaultIconSize,
                right: kDefaultIconSize,
                bottom: kMediumPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Giá vé',
                        style: AppStyles.h5.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        'Rp 150.000',
                        style: AppStyles.h3,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(CheckOut.routeName, arguments: movie);
                    },
                    child: Container(
                      height: 46,
                      width: 120,
                      decoration: const BoxDecoration(
                        color: AppColors.blueMain,
                        borderRadius: kDefaultBorderRadius,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Đặt vé',
                        style: AppStyles.h4,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
