import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/models/response/ticket_response.dart';
import 'package:movie_ticker_app_flutter/provider/ticket_provider.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class TicketDetailWidget extends StatelessWidget {
  const TicketDetailWidget({
    Key? key,
    required this.size,
    required this.ticket,
    required this.seats,
    required this.formattedString,
  }) : super(key: key);

  final Size size;
  final TicketResponse ticket;
  final String seats;
  final String formattedString;

  @override
  Widget build(BuildContext context) {
    final ticketProvider = context.read<TicketProvider>();

    return Container(
      margin: const EdgeInsets.all(kDefaultPadding),
      width: size.width / 1.1,
      height: size.height / 5,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ticketProvider.checkScreeningEndTime(ticket)
                ? Colors.white
                : Colors.amber.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: ticketProvider.checkScreeningEndTime(ticket)
            ? Colors.black12
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                ticket.movieTitle,
                style: GoogleFonts.beVietnamPro(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                'Ngày đặt vé: $formattedString',
                style: GoogleFonts.beVietnamPro(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Text(
                'Suất chiếu: ${ticket.screeningDate}, ${ticket.screeningStartTime.substring(0, 5)}',
                style: GoogleFonts.beVietnamPro(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Text(
                'Rạp: ${ticket.screening.auditorium.cinema.name}',
                style: GoogleFonts.beVietnamPro(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Text(
                'Phòng chiếu: ${ticket.auditoriumName}',
                style: GoogleFonts.beVietnamPro(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Text(
                'Ghế: $seats',
                style: GoogleFonts.beVietnamPro(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Text(
                'Giá vé: ${ticket.total}đ',
                style: GoogleFonts.beVietnamPro(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
