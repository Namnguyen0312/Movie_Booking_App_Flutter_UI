import 'package:movie_ticker_app_flutter/models/genre.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/utils/helper.dart';

class TempDB {
  static final List<Movie> movies = [
    Movie(
      1,
      'Dragon Training',
      100,
      AssetHelper.imgDragon,
      4.5,
      '2022-12-31',
      '2022-01-01',
      [tableGenres[0], tableGenres[1]],
      'A story about training dragons.',
      ['Director 1'],
      ['Nguyễn Lê Văn', 'Actor 2'],
      [AssetHelper.imgTrailer1, AssetHelper.imgTrailer2],
    ),
    Movie(
      2,
      'Frozen 2',
      104,
      AssetHelper.imgFrozen,
      4.7,
      '2023-12-31',
      '2023-01-01',
      [tableGenres[0], tableGenres[1]],
      'The sequel to Frozen.',
      ['Director 2'],
      ['Nguyễn Lê Văn', 'Actor 4'],
      [AssetHelper.imgMovieBanner, AssetHelper.imgMoviePoster],
    ),
    Movie(
      3,
      'Onward',
      102,
      AssetHelper.imgOnward,
      4.2,
      '2022-10-01',
      '2022-02-01',
      [tableGenres[0], tableGenres[1]],
      'Two elf brothers go on a quest.',
      ['Director 3'],
      ['Nguyễn Lê Văn', 'Actor 6'],
      [AssetHelper.imgMoviePoster2, AssetHelper.imgMoviePoster3],
    ),
    Movie(
      4,
      'Ralph Internet',
      110,
      AssetHelper.imgRalph,
      4.0,
      '2022-09-30',
      '2022-03-01',
      [tableGenres[0], tableGenres[1]],
      'Ralph breaks the internet.',
      ['Director 4'],
      ['Nguyễn Lê Văn', 'Actor 8'],
      [AssetHelper.imgTrailer1, AssetHelper.imgTrailer2],
    ),
    Movie(
      5,
      'Scoob',
      95,
      AssetHelper.imgScoob,
      4.5,
      '2022-11-30',
      '2022-04-01',
      [tableGenres[0], tableGenres[1]],
      'Scooby-Doo and the gang.',
      ['Director 5'],
      ['Actor 9', 'Actor 10'],
      [AssetHelper.imgMovieBanner, AssetHelper.imgMoviePoster],
    ),
    Movie(
      6,
      'Lab Krixi',
      120,
      AssetHelper.imgSpongebob,
      3.9,
      '2023-08-15',
      '2023-05-01',
      [tableGenres[0], tableGenres[1], tableGenres[2], tableGenres[3]],
      'A fantasy adventure.',
      ['Director 6'],
      ['Nguyễn Lê Văn', 'Actor 2'],
      [AssetHelper.imgMoviePoster2, AssetHelper.imgMoviePoster3],
    ),
  ];

  static List<String> getMovieNames() {
    return movies.map((movie) => movie.title).toList();
  }

  static final List<Genre> tableGenres = [
    Genre(
      id: 1,
      name: 'Action',
    ),
    Genre(
      id: 1,
      name: 'Drama',
    ),
    Genre(
      id: 1,
      name: 'Horror',
    ),
    Genre(
      id: 1,
      name: 'Humorous',
    ),
    Genre(
      id: 1,
      name: 'Tail',
    ),
  ];
}
