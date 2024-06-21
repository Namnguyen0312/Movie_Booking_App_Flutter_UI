import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;

  const CustomVideoPlayer({super.key, required this.controller});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VoidCallback _listener;
  bool _isPlaying = false;
  bool _isMuted = false;
  bool _showControls = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _listener = () {
      final bool isPlaying = widget.controller.value.isPlaying;
      final Duration position = widget.controller.value.position;
      final Duration duration = widget.controller.value.duration;
      if (isPlaying != _isPlaying ||
          position != _position ||
          duration != _duration) {
        setState(() {
          _isPlaying = isPlaying;
          _position = position;
          _duration = duration;
        });
      }

      if (position >= duration) {
        Navigator.of(context).pop();
      }
    };
    widget.controller.addListener(_listener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  void _togglePlayPause() {
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
    } else {
      widget.controller.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _toggleControls() {
    if (!mounted) return; // Check if the state object is still mounted

    setState(() {
      _showControls = !_showControls;
    });

    if (_showControls) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted && _showControls) {
          // Check mounted before setState
          setState(() {
            _showControls = false;
          });
        }
      });
    }
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    widget.controller.setVolume(_isMuted ? 0 : 1);
  }

  void _onSeek(double value) {
    final Duration duration = widget.controller.value.duration;
    final newPosition = duration * value;
    widget.controller.seekTo(newPosition);
    setState(() {
      _position = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleControls,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: widget.controller.value.aspectRatio,
            child: VideoPlayer(widget.controller),
          ),
          if (_showControls)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Colors.black.withOpacity(0.5),
                ),
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: _togglePlayPause,
                      icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                      color: Colors.white,
                    ),
                    Flexible(
                      child: Slider(
                        value: _duration.inSeconds > 0
                            ? _position.inSeconds / _duration.inSeconds
                            : 0.0,
                        onChanged: _duration.inSeconds > 0 ? _onSeek : null,
                        activeColor: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: _toggleMute,
                      icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
