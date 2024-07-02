import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/custom_back_arrow.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/list_star_widget.dart';
import 'package:movie_ticker_app_flutter/models/response/seat_response.dart';
import 'package:movie_ticker_app_flutter/models/response/vourcher_response.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/seat_provider.dart';
import 'package:movie_ticker_app_flutter/provider/ticket_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/provider/vourcher_provider.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/build_price_tag.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/widgets/submit_order_widget.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/home_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_right_curve.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  String? selectedVoucherValue;
  VourcherResponse? selectedVoucher;
  Future<void> fetchVouchers() async {
    final vourcherProvider =
        Provider.of<VourcherProvider>(context, listen: false);
    await vourcherProvider.getAllVourchers();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final appProvider = context.watch<AppProvider>();
    final seatProvider = context.watch<SeatProvider>();
    final userProvider = context.watch<UserProvider>();
    final ticketProvider = context.watch<TicketProvider>();
    final vourcherProvider = context.watch<VourcherProvider>();

    List<SeatResponse> sortedSeats =
        seatProvider.getSortedSeats(seatProvider.seats);

    String seat = sortedSeats
        .where((seat) => seatProvider.selectedSeatIds.contains(seat.id))
        .map((seat) => '${seat.rowSeat}${seat.numberSeat}')
        .join(', ');

    String genres =
        appProvider.selectedMovie!.genres.map((genre) => genre.name).join(', ');

    String address =
        ' ${userProvider.user!.address.street}, ${userProvider.user!.address.district}, ${userProvider.user!.address.ward}, ${userProvider.user!.address.city}';

    int price = (seatProvider.totalPrice * 1000).toInt();
    int discountByMembership =
        (price * userProvider.user!.membership.discountRate).toInt();
    int totalPrice = price - discountByMembership;

    if (selectedVoucherValue != null) {
      selectedVoucher = vourcherProvider.vourchers!.firstWhere((voucher) =>
          '${voucher.content} ${voucher.discount}%' == selectedVoucherValue);
      totalPrice =
          (totalPrice * (1 - (selectedVoucher!.discount ?? 0) / 100)).toInt();
    }

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
        elevation: 10,
        shadowColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                        placeholder: (context, url) => const Center(
                          child: SpinKitFadingCircle(
                            color: Colors.grey,
                            size: 50.0,
                          ),
                        ),
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
              Container(
                margin: const EdgeInsets.only(
                    left: kMediumPadding, right: kMediumPadding),
                decoration: const BoxDecoration(
                    border: BorderDirectional(
                        top: BorderSide(color: Colors.white))),
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
                        content:
                            'Ưu đãi theo bậc (${userProvider.user!.membership.description})',
                        price: '$discountByMembershipđ'),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: kItemPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mã giảm giá',
                            style: GoogleFonts.beVietnamPro(
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          FutureBuilder<void>(
                            future: fetchVouchers(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return const Text("Có lỗi xảy ra");
                              } else {
                                List<VourcherResponse> vouchers =
                                    vourcherProvider.vourchers!;
                                return DropdownButton<String>(
                                  dropdownColor: AppColors.darkerBackground,
                                  hint: Text(
                                    "Chọn mã giảm giá",
                                    style: GoogleFonts.beVietnamPro(
                                        textStyle: const TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                  ),
                                  value: selectedVoucherValue,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedVoucherValue = newValue;
                                    });
                                  },
                                  items: vouchers.map<DropdownMenuItem<String>>(
                                      (VourcherResponse voucher) {
                                    return DropdownMenuItem<String>(
                                      value:
                                          '${voucher.content} ${voucher.discount}%',
                                      child: Text(
                                        '${voucher.content} ${voucher.discount}%',
                                        style: GoogleFonts.beVietnamPro(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white)),
                                      ),
                                    );
                                  }).toList(),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1.7,
                    ),
                    BuildPriceTag(content: 'Thanh toán', price: '$totalPriceđ'),
                  ],
                ),
              ),
              if (selectedVoucher != null)
                SubmitOrderWidget(
                    ticketProvider: ticketProvider,
                    totalPrice: totalPrice,
                    seatProvider: seatProvider,
                    appProvider: appProvider,
                    userProvider: userProvider,
                    vourcher: selectedVoucher,
                    size: size)
            ],
          ),
        ),
      ),
    );
  }
}
