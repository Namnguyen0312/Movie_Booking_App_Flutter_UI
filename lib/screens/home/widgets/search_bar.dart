import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_styles.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';

class SearchBarFirm extends StatefulWidget {
  const SearchBarFirm({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<SearchBarFirm> createState() => _SearchBarFirmState();
}

class _SearchBarFirmState extends State<SearchBarFirm> {
  String? _selectedGenre;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kMediumPadding),
      child: SizedBox(
        height: widget.size.height / 15,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: widget.size.height / 15,
                margin: const EdgeInsets.only(right: kDefaultPadding),
                decoration: const BoxDecoration(
                  color: AppColors.darkBackground,
                  borderRadius: kBigBorderRadius,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: kMediumPadding, right: kMediumPadding),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: kDefaultIconSize,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        style: AppStyles.h3,
                        decoration: InputDecoration(
                          hintText: 'Tìm Kiếm',
                          hintStyle:
                              AppStyles.h3.copyWith(color: AppColors.grey),
                          fillColor: Colors.lightBlue,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _showGenreSelection(context),
              child: Container(
                height: widget.size.height / 15,
                width: widget.size.height / 15,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Gradients.lightBlue1,
                      Gradients.lightBlue2,
                    ],
                  ),
                  borderRadius: kDefaultBorderRadius,
                ),
                child: Center(
                  child: _selectedGenre == null
                      ? Image.asset(
                          AssetHelper.icoControl,
                        )
                      : Text(
                          _getInitials(_selectedGenre!),
                          style: AppStyles.h2.copyWith(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showGenreSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(kMediumPadding),
          decoration: const BoxDecoration(
            color: AppColors.darkBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Genre',
                style: AppStyles.h2,
              ),
              const SizedBox(height: kMediumPadding),
              ListView(
                shrinkWrap: true,
                children: _buildGenreList(context),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildGenreList(BuildContext context) {
    final genres = listTypes;

    return genres
        .map((genre) => ListTile(
              title: Text(
                genre,
                style: AppStyles.h3,
              ),
              onTap: () {
                setState(() {
                  _selectedGenre = genre;
                });
                Navigator.pop(context);
              },
            ))
        .toList();
  }

  String _getInitials(String genre) {
    final genres = listTypes;
    final initialChars = <String>{};
    for (var g in genres) {
      if (g == genre) break;
      if (g.length >= 2) {
        initialChars.add(g.substring(0, 2).toUpperCase());
      } else {
        initialChars.add(g[0].toUpperCase());
      }
    }

    if (!initialChars.contains(genre.substring(0, 2).toUpperCase())) {
      return genre.substring(0, 2).toUpperCase();
    }

    for (int i = 0; i < genre.length; i++) {
      if (!initialChars.contains(genre[i].toUpperCase())) {
        return genre[i].toUpperCase();
      }
    }

    return genre[0].toUpperCase(); // Fallback
  }
}
