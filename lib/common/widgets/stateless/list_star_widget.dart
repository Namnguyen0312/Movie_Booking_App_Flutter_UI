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
        if (movie.star != null && movie.star! >= 4)
          ...List.generate(4, (index) => const StarWidget()),
        if (movie.star != null && movie.star! > 4 && movie.star! < 5)
          const StarHalfWidget(),
        if (movie.star != null && movie.star! == 5)
          ...List.generate(5, (index) => const StarWidget()),
        if (movie.star != null && movie.star! < 4)
          ...List.generate(3, (index) => const StarWidget()),
        if (movie.star != null && movie.star! > 3 && movie.star! < 4)
          const StarHalfWidget(),
        Text(
          ' (${movie.star})',
          style: AppStyles.h5,
        ),
      ],
    );
  }
}
