import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/custom_back_arrow.dart';
import 'package:movie_ticker_app_flutter/provider/new_provider.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class NewsDetailPage extends StatefulWidget {
  const NewsDetailPage({super.key});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  void _showContentDialog(String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SingleChildScrollView(
            child: Text(
              content,
              style:
                  GoogleFonts.beVietnamPro(color: Colors.white, fontSize: 17),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final newProvider = context.watch<NewProvider>();
    final Size size = MediaQuery.of(context).size;

    String formattedString = DateFormat('dd/MM/yyyy, HH:mm')
        .format(newProvider.selectedNew!.created!);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.white,
          leading: const CustomBackArrow()),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: newProvider.selectedNew!.imageUrl!,
                width: size.width,
                fit: BoxFit.cover,
              ),
              Container(
                width: size.width,
                height: size.height / 3,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black38,
                      Colors.black12,
                      Colors.transparent
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: kMediumPadding,
          ),
          Flexible(
              child: Text(
            '${newProvider.selectedNew!.title}',
            style: GoogleFonts.beVietnamPro(color: Colors.white, fontSize: 25),
          )),
          const SizedBox(
            height: kMinPadding,
          ),
          Flexible(
              child: Text(
            formattedString,
            style:
                GoogleFonts.beVietnamPro(color: Colors.white24, fontSize: 15),
          )),
          const SizedBox(
            height: kDefaultPadding,
          ),
          Flexible(
              child: GestureDetector(
            onTap: () => _showContentDialog(newProvider.selectedNew!.content!),
            child: Text(
              '${newProvider.selectedNew!.content}',
              style:
                  GoogleFonts.beVietnamPro(color: Colors.white54, fontSize: 15),
            ),
          )),
        ],
      ),
    );
  }
}
