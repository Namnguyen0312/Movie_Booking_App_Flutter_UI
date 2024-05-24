import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';

class ShowtimeCard extends StatelessWidget {
  final Screening screening;

  const ShowtimeCard({required this.screening, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              screening.auditoriums.first.cinema.name,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.veryDark,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              screening.start,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
