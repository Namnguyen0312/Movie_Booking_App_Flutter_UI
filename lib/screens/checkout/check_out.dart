import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/list_star_widget.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/seat_provider.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/my_ticket.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/build_price_tag.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/widgets/custom_header.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  static const routeName = '/check_out';

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final appProvider = context.watch<AppProvider>();
    final seatProvider = context.watch<SeatProvider>();
    String seat =
        seatProvider.selectedSeats.map((seat) => seat.numberSeat).join(', ');

    String genres =
        appProvider.selectedMovie!.genres.map((genre) => genre.name).join(', ');
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(
              size: size,
              content: 'Kiểm Vé',
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: AppColors.white, width: 1)),
              ),
              margin: const EdgeInsets.symmetric(
                  horizontal: kMediumPadding, vertical: kMediumPadding),
              padding: const EdgeInsets.only(bottom: kTop32Padding),
              child: Row(
                children: [
                  SizedBox(
                    width: size.width / 4.3,
                    child: Image(
                      image: AssetImage(appProvider.selectedMovie!.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: kMediumPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: kMinPadding),
                            child: Text(
                              appProvider.selectedMovie!.title.toString(),
                              style: AppStyles.h3,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: kMinPadding),
                            child: ListStarWidget(
                                movie: appProvider.selectedMovie!),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: kMinPadding),
                            child: Text(
                              genres,
                              style:
                                  AppStyles.h4.copyWith(color: AppColors.grey),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: kMinPadding),
                            child: Text(
                              '${appProvider.selectedMovie!.duration} phút',
                              style:
                                  AppStyles.h4.copyWith(color: AppColors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const BuildPriceTag(content: 'ID Order', price: '22081996'),
            BuildPriceTag(
                content: 'Cinema', price: appProvider.selectedCinema!.name),
            BuildPriceTag(
                content: 'Date & Time',
                price:
                    '${appProvider.selectedScreening!.date}, ${appProvider.selectedScreening!.start}'),
            BuildPriceTag(content: 'Seat Number', price: seat),
            BuildPriceTag(
                content: 'Price', price: '${seatProvider.totalPrice}'),
            // Container(
            //   padding: const EdgeInsets.only(
            //     top: kItemPadding,
            //     bottom: kTop32Padding,
            //   ),
            //   margin: const EdgeInsets.symmetric(horizontal: kMediumPadding),
            //   decoration: const BoxDecoration(
            //     border: Border(
            //       bottom: BorderSide(color: AppColors.white, width: 1),
            //     ),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'Total',
            //         style: AppStyles.h4.copyWith(color: AppColors.grey),
            //       ),
            //       Text(
            //         'Rp 150.000',
            //         style: AppStyles.h4.copyWith(fontWeight: FontWeight.w600),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.only(
                top: kMediumPadding,
                bottom: kTop32Padding,
              ),
              margin: const EdgeInsets.symmetric(horizontal: kMediumPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Wallet',
                    style: AppStyles.h4.copyWith(color: AppColors.grey),
                  ),
                  Text(
                    'IDR 200.000',
                    style: AppStyles.h4.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.blueMain,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(MyTicket.routeName);
              },
              child: Container(
                height: 60,
                width: size.width / 1.5,
                decoration: const BoxDecoration(
                  color: AppColors.blueMain,
                  borderRadius: kDefaultBorderRadius,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Thanh Toán',
                  style: AppStyles.h3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
