import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/custom_back_arrow.dart';
import 'package:movie_ticker_app_flutter/models/response/ticket_response.dart';

import 'package:movie_ticker_app_flutter/screens/myticket/widgets/image_widget.dart';

import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';

class TicketDetailPage extends StatelessWidget {
  const TicketDetailPage({
    super.key,
    required this.size,
    required this.ticket,
    required this.seats,
  });

  final Size size;
  final TicketResponse ticket;
  final String seats;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(ticket.orderTime);

    String formattedString = DateFormat('dd-MM-yyyy, HH:mm').format(dateTime);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Thông tin vé',
          style: GoogleFonts.beVietnamPro(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
        leading: const CustomBackArrow(),
        elevation: 10,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding,
                  top: kTop32Padding),
              child: ImageWidget(seats: seats, ticket: ticket),
            ),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  top: kTop32Padding),
              child: Row(
                children: [
                  SizedBox(
                    height: size.height / 5.1,
                    child: CachedNetworkImage(
                      imageUrl: ticket.qrcode,
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
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: kDefaultPadding,
                            bottom: kDefaultPadding,
                          ),
                          width: size.width,
                          child: Text(
                            'Giá vé: ${ticket.total}đ',
                            style: GoogleFonts.beVietnamPro(
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: kDefaultPadding,
                            bottom: kDefaultPadding,
                          ),
                          width: size.width,
                          child: Text(
                            'Thời gian đặt vé: $formattedString',
                            style: GoogleFonts.beVietnamPro(
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: kDefaultPadding,
                            bottom: kDefaultPadding,
                          ),
                          width: size.width,
                          child: Text(
                            'Rạp: ${ticket.screening.auditorium.cinema.name}',
                            style: GoogleFonts.beVietnamPro(
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: kDefaultPadding,
                            bottom: kDefaultPadding,
                          ),
                          width: size.width,
                          child: Text(
                            'Phòng chiếu: ${ticket.screening.auditorium.name}',
                            style: GoogleFonts.beVietnamPro(
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: kDefaultPadding,
                            bottom: kDefaultPadding,
                          ),
                          width: size.width,
                          child: Text(
                            'Suất chiếu: ${ticket.screeningDate}, ${ticket.screeningStartTime.substring(0, 5)}',
                            style: GoogleFonts.beVietnamPro(
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  top: kTop32Padding),
              width: size.width,
              child: Text(
                'Vui lòng đưa thông tin vé này cho nhân viên ở quầy để xác nhận thanh toán cho bạn',
                style: GoogleFonts.beVietnamPro(
                  textStyle:
                      const TextStyle(fontSize: 16, color: Colors.white60),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
