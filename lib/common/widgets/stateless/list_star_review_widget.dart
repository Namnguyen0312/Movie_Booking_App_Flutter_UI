import 'package:flutter/material.dart';

class ListStarReviewWidget extends StatelessWidget {
  const ListStarReviewWidget({super.key, required this.numberStar});

  final int numberStar;

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = List.generate(5, (index) {
      if (index < numberStar) {
        return Icon(
          Icons.star,
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
      ],
    );
  }
}
