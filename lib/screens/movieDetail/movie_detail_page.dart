import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/list_star_widget.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/widgets/about_title_widget.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/widgets/trailer_bar.dart';
import 'package:movie_ticker_app_flutter/screens/screening/select_screening_by_movie_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key});

  static const String routeName = '/movie_detail_page';

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late VideoPlayerController _controller; // Video player controller

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    final provider = context.read<AppProvider>();
    final selectedMovie = provider.selectedMovie!;

    // Initialize video player controller
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(selectedMovie.trailers));
    _controller.initialize().then((_) {
      setState(() {}); // Update state after video is initialized
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose(); // Dispose video player controller
    super.dispose();
  }

  void _showVideoDialog() {
    showDialog(
      barrierColor: Colors.black87,
      context: context,
      barrierDismissible: true, // Allow dismiss by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: CustomVideoPlayer(
                controller: _controller,
              ),
            ),
          ),
        );
      },
    ).then((_) {
      _controller.pause();
      _controller.seekTo(Duration.zero);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = context.watch<AppProvider>();

    String genres =
        provider.selectedMovie!.genres.map((genre) => genre.name).join(', ');
    String cast = provider.selectedMovie!.casts.join(', ');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: kMediumPadding,
                top: kMediumPadding,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _showVideoDialog,
                    child: SizedBox(
                      height: size.height / 3.5,
                      child: CachedNetworkImage(
                        imageUrl: provider.selectedMovie!.image,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                        fit: BoxFit.cover,
                      ),
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
                            provider.selectedMovie!.title,
                            style: GoogleFonts.beVietnamPro(
                              textStyle: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: kDefaultPadding,
                            bottom: kDefaultPadding,
                          ),
                          width: size.width,
                          child: ListStarWidget(
                              rating: provider.selectedMovie!.rating),
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
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.only(
                            left: kDefaultPadding,
                            bottom: kDefaultPadding,
                          ),
                          width: size.width,
                          child: Text(
                            'Thời lượng: ${provider.selectedMovie!.duration} phút',
                            style: GoogleFonts.beVietnamPro(
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                SelectScreeningByMoviePage.routeName,
                                arguments: provider.selectedMovie!);
                          },
                          child: Container(
                            height: size.height / 15,
                            width: size.height / 4.6,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Gradients.lightBlue1,
                                  Gradients.lightBlue2,
                                ],
                              ),
                              borderRadius: kDefaultBorderRadius,
                            ),
                            child: Center(
                              child: Text(
                                'Đặt vé',
                                style: GoogleFonts.beVietnamPro(
                                  textStyle:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          const SliverToBoxAdapter(
            child: Divider(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AboutTitle(title: 'Mô Tả'),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding,
                        horizontal: kDefaultIconSize),
                    width: size.width,
                    child: Text(
                      provider.selectedMovie!.description,
                      style: GoogleFonts.beVietnamPro(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )),
                const AboutTitle(title: 'Đạo diễn'),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding,
                        horizontal: kDefaultIconSize),
                    width: size.width,
                    child: Text(
                      provider.selectedMovie!.director,
                      style: GoogleFonts.beVietnamPro(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )),
                const AboutTitle(title: 'Diễn Viên'),
                Container(
                    padding: const EdgeInsets.only(
                        top: kDefaultPadding,
                        bottom: kTop32Padding,
                        left: kDefaultIconSize,
                        right: kDefaultIconSize),
                    width: size.width,
                    child: Text(
                      cast,
                      style: GoogleFonts.beVietnamPro(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
