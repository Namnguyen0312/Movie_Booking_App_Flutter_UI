// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// import '../../../models/movie.dart';
// import '../../../themes/app_colors.dart';
// import '../../../utils/constants.dart';

// class TrailerBar extends StatefulWidget {
//   const TrailerBar({
//     Key? key,
//     required this.movie,
//     required this.size,
//   }) : super(key: key);

//   final Movie? movie;
//   final Size size;

//   @override
//   State<TrailerBar> createState() => _TrailerBarState();
// }

// class _TrailerBarState extends State<TrailerBar> {
//   late VideoPlayerController _videoController;

//   @override
//   void initState() {
//     super.initState();
//     _videoController = VideoPlayerController.networkUrl(Uri.parse(
//         'http://res.cloudinary.com/do9bojdku/video/upload/v1717242492/jgjfnbhjt2hjake9hgm0.mp4'))
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         top: kDefaultPadding,
//         right: kDefaultPadding,
//       ),
//       child: _videoController.value.isInitialized
//           ? SizedBox(
//               height: widget.size.height / 4.5,
//               width: widget.size.width / 1.5,
//               child: Stack(
//                 children: [
//                   AspectRatio(
//                     aspectRatio: _videoController.value.aspectRatio,
//                     child: VideoPlayer(_videoController),
//                   ),
//                   Container(
//                     height: widget.size.height / 4.5,
//                     width: widget.size.width / 1.5,
//                     decoration: const BoxDecoration(
//                       color: Gradients.darkGreyMid,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       if (_videoController.value.isPlaying) {
//                         _videoController.pause();
//                       } else {
//                         _videoController.play();
//                       }
//                     },
//                     child: SizedBox(
//                       height: widget.size.height / 4.5,
//                       width: widget.size.width / 1.5,
//                       child: Container(
//                         margin: EdgeInsets.all(widget.size.width / 7),
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: AppColors.blueMain,
//                         ),
//                         child: Icon(
//                           _videoController.value.isPlaying
//                               ? Icons.pause
//                               : Icons.play_arrow,
//                           color: Colors.white,
//                           size: 50,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : const CircularProgressIndicator(), // Placeholder while video is loading
//     );
//   }

//   @override
//   void dispose() {
//     _videoController.dispose();
//     super.dispose();
//   }
// }
