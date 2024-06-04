import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:video_player/video_player.dart';

class BackgroundWidget extends StatefulWidget {
  const BackgroundWidget({super.key, required this.size});

  final Size size;

  @override
  State<BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  late VideoPlayerController _controller;
  late bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Hiển thị video nếu đã khởi tạo, nếu không thì hiển thị màu nền xám
        _controller.value.isInitialized
            ? SizedBox(
                height: widget.size.height / 3,
                width: widget.size.width,
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                          _isPlaying = _controller.value.isPlaying;
                        });
                      },
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _isPlaying
                              ? const SizedBox.shrink()
                              : const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 50,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: widget.size.height / 3,
                color: AppColors.greyBackground,
              ),
      ],
    );
  }
}
