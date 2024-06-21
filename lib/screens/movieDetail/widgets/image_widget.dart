import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/list_star_widget.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/widgets/trailer_bar.dart';
import 'package:movie_ticker_app_flutter/screens/screening/select_screening_by_movie_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key});

  @override
  State<ImageWidget> createState() => _ImageWidget();
}

class _ImageWidget extends State<ImageWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  VideoPlayerController? _controller;
  bool _isVideoLoading = false; // Để theo dõi trạng thái tải video

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller?.dispose(); // Dispose video player controller
    super.dispose();
  }

  void _showVideoDialog() {
    // Khởi tạo video player controller và bắt đầu tải video khi nhấn vào nút play
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final selectedMovie = appProvider.selectedMovie!;
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(selectedMovie.trailers));

    setState(() {
      _isVideoLoading = true;
    });

    _controller!.initialize().then((_) {
      setState(() {
        _isVideoLoading = false;
      });
      showDialog(
        barrierColor: Colors.black87,
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: CustomVideoPlayer(
                  controller: _controller!,
                ),
              ),
            ),
          );
        },
      ).then((_) {
        _controller!.pause();
        _controller!.seekTo(Duration.zero);
        _controller!.dispose();
        _controller = null;
      });
    }).catchError((error) {
      print('Error initializing video: $error');
      setState(() {
        _isVideoLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appProvider = context.watch<AppProvider>();

    String genres =
        appProvider.selectedMovie!.genres.map((genre) => genre.name).join(', ');

    return Row(
      children: [
        Stack(
          children: [
            SizedBox(
              height: size.height / 3.5,
              child: CachedNetworkImage(
                imageUrl: appProvider.selectedMovie!.image,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: _showVideoDialog,
                  child: Icon(
                    Icons.play_circle_outline,
                    color: Colors.deepPurple[200],
                    size: 60.0,
                  ),
                ),
              ),
            ),
          ],
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
                  appProvider.selectedMovie!.title,
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
                child:
                    ListStarWidget(rating: appProvider.selectedMovie!.rating),
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
                  'Thời lượng: ${appProvider.selectedMovie!.duration} phút',
                  style: GoogleFonts.beVietnamPro(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              if (!appProvider.isComingSoon)
                GestureDetector(
                  onTap: () {
                    context.read<AppProvider>().reset();
                    Navigator.of(context).push(
                      AnimateLeftCurve.createRoute(
                        const SelectScreeningByMoviePage(),
                      ),
                    );
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
                          textStyle: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
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
