import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/custom_back_arrow.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/list_star_widget.dart';
import 'package:movie_ticker_app_flutter/models/response/seat_response.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/seat_provider.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/my_ticket.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/build_price_tag.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
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
    List<SeatResponse> sortedSeats = seatProvider.getSortedSeats();
    String seat = sortedSeats
        .where((seat) => seatProvider.selectedSeatIds.contains(seat.id))
        .map((seat) => '${seat.rowSeat}${seat.numberSeat}')
        .join(', ');

    String genres =
        appProvider.selectedMovie!.genres.map((genre) => genre.name).join(', ');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Kiểm vé',
          style: GoogleFonts.beVietnamPro(
            textStyle: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
        leading: const CustomBackArrow(),
      ),
      body: SafeArea(
        child: Column(
          children: [
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const BuildPriceTag(content: 'ID Order', price: '22081996'),
                    BuildPriceTag(
                        content: 'Cinema',
                        price: appProvider.selectedCinema!.name),
                    BuildPriceTag(
                        content: 'Date & Time',
                        price:
                            '${appProvider.selectedScreening!.date}, ${appProvider.selectedScreening!.start}'),
                    BuildPriceTag(content: 'Seat Number', price: seat),
                    BuildPriceTag(
                        content: 'Price',
                        price:
                            '${int.parse(seatProvider.totalPrice.toStringAsFixed(0)) * 1000}đ'),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: kDefaultPadding),
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(right: kDefaultPadding),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(MyTicket.routeName);
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
