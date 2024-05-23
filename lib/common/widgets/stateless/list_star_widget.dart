import 'package:flutter/cupertino.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';

import '../../../themes/app_styles.dart';
import 'star_half_widget.dart';
import 'star_widget.dart';

class ListStarWidget extends StatelessWidget {
  const ListStarWidget({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (movie.rating >= 4)
          ...List.generate(4, (index) => const StarWidget()),
        if (movie.rating > 4 && movie.rating < 5) const StarHalfWidget(),
        if (movie.rating == 5)
          ...List.generate(5, (index) => const StarWidget()),
        if (movie.rating < 4)
          ...List.generate(3, (index) => const StarWidget()),
        if (movie.rating > 3 && movie.rating < 4) const StarHalfWidget(),
        Text(
          ' (${movie.rating})',
          style: AppStyles.h5,
        ),
      ],
    );
  }
}
