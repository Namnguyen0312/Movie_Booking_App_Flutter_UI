import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/custom_back_arrow.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/list_star_widget.dart';
import 'package:movie_ticker_app_flutter/models/response/seat_response.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/seat_provider.dart';
import 'package:movie_ticker_app_flutter/provider/ticket_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/build_price_tag.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/my_ticket.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/home_page.dart';
import 'package:movie_ticker_app_flutter/screens/payment/payment_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:movie_ticker_app_flutter/utils/animate_right_curve.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final appProvider = context.watch<AppProvider>();
    final seatProvider = context.watch<SeatProvider>();
    final userProvider = context.watch<UserProvider>();
    final ticketProvider = context.watch<TicketProvider>();

    List<SeatResponse> sortedSeats = seatProvider.getSortedSeats();

    String seat = sortedSeats
        .where((seat) => seatProvider.selectedSeatIds.contains(seat.id))
        .map((seat) => '${seat.rowSeat}${seat.numberSeat}')
        .join(', ');

    String genres =
        appProvider.selectedMovie!.genres.map((genre) => genre.name).join(', ');

    String address =
        '${userProvider.user!.address.ward}, ${userProvider.user!.address.street}, ${userProvider.user!.address.district}, ${userProvider.user!.address.city}';

    int price = int.parse(seatProvider.totalPrice.toStringAsFixed(0)) * 1000;
    int sale = int.parse(seatProvider.totalPrice.toStringAsFixed(0)) * 1000;
    int totalPrice = price - 0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Kiểm vé',
          style: GoogleFonts.beVietnamPro(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
        leading: const CustomBackArrow(),
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: kMediumPadding,
                  right: kMediumPadding,
                  left: kMediumPadding),
              padding: const EdgeInsets.only(bottom: kMediumPadding),
              child: Row(
                children: [
                  SizedBox(
                    width: size.width / 3,
                    child: CachedNetworkImage(
                      imageUrl: appProvider.selectedMovie!.image,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
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
                              appProvider.selectedMovie!.title,
                              style: GoogleFonts.beVietnamPro(
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: kMinPadding),
                            child: ListStarWidget(
                                rating: appProvider.selectedMovie!.rating),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: kMinPadding),
                            child: Text(
                              genres,
                              style: GoogleFonts.beVietnamPro(
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: kMinPadding),
                            child: Text(
                              '${appProvider.selectedMovie!.duration} phút',
                              style: GoogleFonts.beVietnamPro(
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                    left: kMediumPadding, right: kMediumPadding),
                decoration: const BoxDecoration(
                    border: BorderDirectional(
                        top: BorderSide(color: Colors.white))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const BuildPriceTag(content: 'Mã ID', price: '22081996'),
                      BuildPriceTag(
                          content: 'Tên', price: userProvider.user!.name),
                      BuildPriceTag(content: 'Địa chỉ', price: address),
                      BuildPriceTag(
                          content: 'Rạp phim',
                          price: appProvider.selectedCinema!.name),
                      BuildPriceTag(
                          content: 'Ngày và giờ',
                          price:
                              '${appProvider.selectedScreening!.date}, ${appProvider.selectedScreening!.start}'),
                      BuildPriceTag(content: 'Ghế đã đặt', price: seat),
                      BuildPriceTag(content: 'Số tiền', price: '$priceđ'),
                      Divider(
                        indent: size.width / 1.16,
                        thickness: 2.0,
                      ),
                      BuildPriceTag(
                          content: 'Ưu đãi theo bậc', price: '${sale * 0}'),
                      const Divider(
                        thickness: 1.7,
                      ),
                      BuildPriceTag(
                          content: 'Thanh toán', price: '$totalPriceđ'),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: kDefaultPadding),
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(right: kDefaultPadding),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.deepPurple.shade50,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 6,
                        padding: const EdgeInsets.only(
                            left: kDefaultPadding,
                            right: kDefaultPadding,
                            top: kTopPadding),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.only(top: kTopPadding),
                                  child: Center(
                                    child: Text(
                                      'Chọn phương thức thanh toán',
                                      style: GoogleFonts.beVietnamPro(
                                        textStyle: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: kDefaultPadding,
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await ticketProvider.submitOrder(
                                          price,
                                          seatProvider.selectedSeatIds,
                                          appProvider.selectedScreening!.id,
                                          userProvider.user!.id,
                                          appProvider.selectedMovie!.id,
                                        );

                                        if (ticketProvider.url!.isNotEmpty) {
                                          if (!context.mounted) return;
                                          Navigator.of(context).push(
                                            AnimateLeftCurve.createRoute(
                                                const PaymentPage()),
                                          );
                                        }
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.asset(
                                          'assets/images/logo_vnpay.png',
                                          width: 48,
                                          height: 48,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: kDefaultPadding,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.asset(
                                          'assets/images/logo_momo.png',
                                          width: 48,
                                          height: 48,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: size.height / 16,
                  width: size.width / 3,
                  decoration: BoxDecoration(
                    color: AppColors.blueMain,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Thanh toán',
                    style: GoogleFonts.beVietnamPro(
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
