import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/list_star_widget.dart';
import 'package:movie_ticker_app_flutter/models/response/ticket_response.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.seats,
    required this.ticket,
  });

  final String seats;
  final TicketResponse ticket;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    String genres =
        ticket.screening.movie.genres.map((genre) => genre.name).join(', ');

    return Row(
      children: [
        SizedBox(
          height: size.height / 3.5,
          child: CachedNetworkImage(
            imageUrl: ticket.screening.movie.image,
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
                  bottom: kMinPadding,
                ),
                width: size.width,
                child: Text(
                  ticket.screening.movie.title,
                  style: GoogleFonts.beVietnamPro(
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: kDefaultPadding,
                  bottom: kDefaultPadding,
                ),
                width: size.width,
                child: ListStarWidget(rating: ticket.screening.movie.rating),
              ),
              Container(
                padding: const EdgeInsets.only(
                  bottom: kDefaultPadding,
                  left: kDefaultPadding,
                ),
                width: size.width,
                child: Text(
                  genres,
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
                  'Thời lượng: ${ticket.screening.movie.duration} phút',
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
                  'Ghế: $seats',
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
                  'Mã giảm giá: ${ticket.vourcher.content}',
                  style: GoogleFonts.beVietnamPro(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
