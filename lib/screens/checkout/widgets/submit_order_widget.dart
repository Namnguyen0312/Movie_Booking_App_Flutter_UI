import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/models/response/vourcher_response.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/seat_provider.dart';
import 'package:movie_ticker_app_flutter/provider/ticket_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/payment/payment_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';

class SubmitOrderWidget extends StatelessWidget {
  const SubmitOrderWidget({
    super.key,
    required this.ticketProvider,
    required this.totalPrice,
    required this.seatProvider,
    required this.appProvider,
    required this.userProvider,
    required this.vourcher,
    required this.size,
  });

  final TicketProvider ticketProvider;
  final int totalPrice;
  final SeatProvider seatProvider;
  final AppProvider appProvider;
  final UserProvider userProvider;
  final VourcherResponse? vourcher;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          padding: const EdgeInsets.only(top: kTopPadding),
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
                                  totalPrice,
                                  seatProvider.selectedSeatIds,
                                  appProvider.selectedScreening!.id,
                                  userProvider.user!.id,
                                  appProvider.selectedMovie!.id,
                                  vourcher!.id!,
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
                                borderRadius: BorderRadius.circular(20.0),
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
                                borderRadius: BorderRadius.circular(20.0),
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
    );
  }
}
