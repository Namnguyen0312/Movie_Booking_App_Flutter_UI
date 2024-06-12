import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/list_star_review_widget.dart';
import 'package:movie_ticker_app_flutter/models/request/review_request.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/review_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/login/login_screen.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/movie_detail_page.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/widgets/star_rating_checkbox_widget.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    super.key,
    required this.reviewProvider,
    required this.appProvider,
    required this.userProvider,
  });

  final ReviewProvider reviewProvider;
  final AppProvider appProvider;
  final UserProvider userProvider;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late Future<void> _fetchReviewsFuture;

  @override
  void initState() {
    super.initState();
    _fetchReviewsFuture = _fetchReviews();
  }

  Future<void> _fetchReviews() {
    return widget.reviewProvider
        .getAllReivewByMovieId(widget.appProvider.selectedMovie!.id);
  }

  void _addReview(
      int movieId, int userId, ReviewRequest review, String token) async {
    await widget.reviewProvider.createReview(movieId, userId, review, token);
    setState(() {
      _fetchReviewsFuture = _fetchReviews();
    });
  }

  void _showEditDeleteDialog(
      BuildContext context, int reviewId, String comment, int stars) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Bạn có muốn chỉnh sửa?',
            style: GoogleFonts.beVietnamPro(
                textStyle: const TextStyle(color: Colors.black, fontSize: 16)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showEditCommentDialog(context, reviewId, comment, stars);
              },
              child: Text(
                'Chỉnh sửa',
                style: GoogleFonts.beVietnamPro(
                    textStyle: const TextStyle(fontSize: 14)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteReview(reviewId);
              },
              child: Text(
                'Xóa',
                style: GoogleFonts.beVietnamPro(
                    textStyle: const TextStyle(fontSize: 14)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditCommentDialog(
      BuildContext context, int reviewId, String comment, int stars) {
    final TextEditingController commentController =
        TextEditingController(text: comment);
    int selectedStars = stars;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Text(
                        'Chỉnh sửa bình luận',
                        style: GoogleFonts.beVietnamPro(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: TextField(
                        controller: commentController,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: 'Bình luận',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        maxLines: 2,
                        style: GoogleFonts.beVietnamPro(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    for (int i = 0; i < 5; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        child: CheckboxListTile(
                          title: Text('${i + 1} sao'),
                          value: selectedStars == i + 1,
                          onChanged: (value) {
                            setState(() {
                              if (value != null && value) {
                                selectedStars = i + 1;
                              }
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _updateReview(
                        reviewId, commentController.text, selectedStars);
                  },
                  child: Text(
                    'Lưu',
                    style: GoogleFonts.beVietnamPro(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteReview(int reviewId) async {
    final token = widget.userProvider.token!;
    await widget.reviewProvider.deleteReview(reviewId, token);
    setState(() {
      _fetchReviewsFuture = _fetchReviews();
    });
  }

  void _updateReview(int reviewId, String comment, int stars) async {
    final token = widget.userProvider.token!;

    await widget.reviewProvider.updateReview(
        reviewId, ReviewRequest(numberStar: stars, content: comment), token);
    setState(() {
      _fetchReviewsFuture = _fetchReviews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchReviewsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: GoogleFonts.beVietnamPro(
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          );
        } else {
          return widget.reviewProvider.reviews!.isEmpty
              ? Stack(children: [
                  Center(
                      child: Text(
                    'Không có bình luận',
                    style: GoogleFonts.beVietnamPro(
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                  )),
                  Positioned(
                    bottom: kDefaultPadding,
                    right: kDefaultPadding,
                    child: FloatingActionButton(
                      backgroundColor: Colors.blue.shade400,
                      onPressed: () {
                        if (widget.userProvider.isLoggedIn) {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => const StarRatingCheckbox(),
                          ).then((result) {
                            if (result != null) {
                              int selectedStars = result['stars'];
                              String comment = result['comment'];
                              int movieId =
                                  widget.appProvider.selectedMovie!.id;
                              int userId = widget.userProvider.user!.id;
                              String token = widget.userProvider.token!;
                              ReviewRequest review = ReviewRequest(
                                  numberStar: selectedStars, content: comment);
                              _addReview(movieId, userId, review, token);
                            }
                          });
                        } else {
                          context
                              .read<UserProvider>()
                              .selectWidget(const MovieDetailPage());
                          Navigator.of(context).push(
                            AnimateLeftCurve.createRoute(const LoginScreen()),
                          );
                        }
                      },
                      child: const Icon(
                        Icons.comment,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ])
              : Stack(children: [
                  SingleChildScrollView(
                    child: Column(
                      children:
                          widget.reviewProvider.reviews!.reversed.map((review) {
                        DateTime dateTime = DateTime.parse(review.date);
                        String formattedDate =
                            DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
                        bool isUserComment = widget.userProvider.user != null &&
                            review.user.id == widget.userProvider.user!.id;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding,
                              horizontal: kDefaultIconSize),
                          child: GestureDetector(
                            onLongPress: isUserComment
                                ? () => _showEditDeleteDialog(
                                    context,
                                    review.id,
                                    review.content,
                                    review.numberStar)
                                : null,
                            child: Container(
                              padding: const EdgeInsets.all(kMinPadding),
                              decoration: BoxDecoration(
                                  color: isUserComment
                                      ? Colors.indigo.shade300
                                      : Colors.transparent,
                                  borderRadius: kMinBorderRadius,
                                  border: Border.all(
                                      color: isUserComment
                                          ? Colors.white
                                          : Colors.transparent,
                                      width: 2.0)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    review.user.name,
                                    style: GoogleFonts.beVietnamPro(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formattedDate,
                                    style: GoogleFonts.beVietnamPro(
                                      textStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  ListStarReviewWidget(
                                      numberStar: review.numberStar),
                                  const SizedBox(height: 8),
                                  Text(
                                    review.content,
                                    style: GoogleFonts.beVietnamPro(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Positioned(
                    bottom: kDefaultPadding,
                    right: kDefaultPadding,
                    child: FloatingActionButton(
                      backgroundColor: Colors.blue.shade400,
                      onPressed: () {
                        if (widget.userProvider.isLoggedIn) {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => const StarRatingCheckbox(),
                          ).then((result) {
                            if (result != null) {
                              int selectedStars = result['stars'];
                              String comment = result['comment'];
                              int movieId =
                                  widget.appProvider.selectedMovie!.id;
                              int userId = widget.userProvider.user!.id;
                              String token = widget.userProvider.token!;
                              ReviewRequest review = ReviewRequest(
                                  numberStar: selectedStars, content: comment);
                              _addReview(movieId, userId, review, token);
                            }
                          });
                        } else {
                          context
                              .read<UserProvider>()
                              .selectWidget(const MovieDetailPage());
                          Navigator.of(context).push(
                            AnimateLeftCurve.createRoute(const LoginScreen()),
                          );
                        }
                      },
                      child: const Icon(
                        Icons.comment,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]);
        }
      },
    );
  }
}
