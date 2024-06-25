import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/custom_back_arrow.dart';
import 'package:movie_ticker_app_flutter/provider/new_provider.dart';
import 'package:movie_ticker_app_flutter/screens/news/news_detail_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    final newProvider = context.watch<NewProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tin tức',
          style: GoogleFonts.beVietnamPro(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
        leading: const CustomBackArrow(),
      ),
      body: ListView.builder(
        itemCount: newProvider.news!.length,
        itemBuilder: (context, index) {
          String formattedString = DateFormat('dd-MM-yyyy, HH:mm')
              .format(newProvider.news![index].created!);
          return GestureDetector(
            onTap: () {
              context.read<NewProvider>().selectNew(newProvider.news![index]);
              Navigator.of(context).push(
                AnimateLeftCurve.createRoute(const NewsDetailPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text(
                    '${newProvider.news![index].title}',
                    style: GoogleFonts.beVietnamPro(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    formattedString,
                    style: GoogleFonts.beVietnamPro(
                      color: Colors.black38,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
