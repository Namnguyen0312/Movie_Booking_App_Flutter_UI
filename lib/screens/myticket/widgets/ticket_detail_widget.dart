import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticker_app_flutter/models/response/ticket_response.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';

class TicketDetailWidget extends StatelessWidget {
  const TicketDetailWidget({
    super.key,
    required bool isAmberExpanded,
    required this.size,
    required this.ticket,
    required this.seats,
  }) : _isAmberExpanded = isAmberExpanded;

  final bool _isAmberExpanded;
  final Size size;
  final TicketResponse ticket;
  final String seats;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(ticket.orderTime);

    String formattedString = DateFormat('dd-MM-yyyy, HH:mm').format(dateTime);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _isAmberExpanded ? size.width / 8 : size.width / 1.15,
      height: _isAmberExpanded ? size.height / 5 : size.height / 4.5,
      child: Card(
        color: Colors.green.shade200,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Opacity(
            opacity: _isAmberExpanded ? 0 : 1,
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
                    'Chủ sở hữu: ${ticket.userName}',
                    style: GoogleFonts.beVietnamPro(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    'Ngày đặt vé: $formattedString',
                    style: GoogleFonts.beVietnamPro(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    'Ngày: ${ticket.screeningDate}',
                    style: GoogleFonts.beVietnamPro(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    'Giờ bắt đầu: ${ticket.screeningStartTime.substring(0, 5)}',
                    style: GoogleFonts.beVietnamPro(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    'Rạp phim: ${ticket.screening.auditorium.cinema.name}',
                    style: GoogleFonts.beVietnamPro(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
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
                        color: Colors.black54,
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
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
