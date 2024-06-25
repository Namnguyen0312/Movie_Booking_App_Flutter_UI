import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/response/new_response.dart';
import 'package:movie_ticker_app_flutter/provider/new_provider.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/custom_serach_delegate.dart';
import 'package:movie_ticker_app_flutter/screens/news/news_detail_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.news,
  });

  final List<NewResponse> news;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AppBar(
      flexibleSpace: CarouselSlider(
        options: CarouselOptions(
          height: size.height / 4.5,
          autoPlay: true,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
        ),
        items: news.map((newfeed) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  context.read<NewProvider>().selectNew(newfeed);
                  Navigator.of(context).push(
                    AnimateLeftCurve.createRoute(const NewsDetailPage()),
                  );
                },
                child: Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: AppColors.lightBlueNon,
                    borderRadius: kBigBorderRadius,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: newfeed.imageUrl!,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
          icon: const Icon(
            Icons.search,
            color: AppColors.grey,
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu, color: AppColors.grey),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      elevation: 0,
    );
  }
}
