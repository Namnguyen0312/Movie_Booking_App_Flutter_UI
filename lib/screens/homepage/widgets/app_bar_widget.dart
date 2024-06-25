import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/response/new_response.dart';
import 'package:movie_ticker_app_flutter/provider/new_provider.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/custom_serach_delegate.dart';
import 'package:movie_ticker_app_flutter/screens/news/news_detail_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    super.key,
    required this.news,
  });

  final List<NewResponse> news;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AppBar(
      flexibleSpace: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: size.height,
              autoPlay: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              onPageChanged: (index, reason) {
                _currentIndexNotifier.value = index;
              },
            ),
            items: widget.news.map((newfeed) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      context.read<NewProvider>().selectNew(newfeed);
                      Navigator.of(context).push(
                        AnimateLeftCurve.createRoute(const NewsDetailPage()),
                      );
                    },
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: newfeed.imageUrl!,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                          fit: BoxFit.cover,
                          width: size.width,
                        ),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.brown[800]!, width: 4.0)),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.black54,
                                Colors.transparent,
                                Colors.black54
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: ValueListenableBuilder<int>(
                valueListenable: _currentIndexNotifier,
                builder: (context, currentIndex, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(widget.news.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: currentIndex == index ? 12.0 : 8.0,
                        height: currentIndex == index ? 12.0 : 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == index
                              ? Colors.white
                              : Colors.grey,
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        ],
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
