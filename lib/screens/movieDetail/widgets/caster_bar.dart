import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';

class CasterBar extends StatelessWidget {
  const CasterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0), // Padding bên trái
            child: Row(
              children: listCasters.map((caster) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Chip(
                    label: Text(
                      caster,
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: AppColors.darkerBackground,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
