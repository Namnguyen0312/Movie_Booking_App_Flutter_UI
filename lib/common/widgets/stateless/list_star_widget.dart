import 'package:flutter/material.dart';

import '../../../themes/app_styles.dart';

class ListStarWidget extends StatelessWidget {
  const ListStarWidget({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    // Chia tỷ lệ rating từ 0 đến 10 thành 5 phần
    double normalizedRating = rating / 2;

    // Tính số sao đầy
    int fullStars = normalizedRating.floor();

    // Tính nửa sao
    bool hasHalfStar = (normalizedRating - fullStars) >= 0.5;

    // Tạo danh sách sao
    List<Widget> stars = List.generate(5, (index) {
      if (index < fullStars) {
        return Icon(
          Icons.star,
          color: Colors.lime[200],
        );
      } else if (hasHalfStar && index == fullStars) {
        return Icon(
          Icons.star_half,
          color: Colors.lime[200],
        );
      } else {
        return Icon(
          Icons.star_border,
          color: Colors.lime[200],
        );
      }
    });

    return Row(
      children: [
        ...stars,
        // Hiển thị điểm số
        Text(
          ' ($rating)',
          style: AppStyles.h5,
        ),
      ],
    );
  }
}
