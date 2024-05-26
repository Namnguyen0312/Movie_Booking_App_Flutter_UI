import 'package:movie_ticker_app_flutter/models/address.dart';
import 'package:movie_ticker_app_flutter/models/auditorium.dart';
import 'package:movie_ticker_app_flutter/models/cinema.dart';
import 'package:movie_ticker_app_flutter/models/genre.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';
import 'package:movie_ticker_app_flutter/models/seat.dart';
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
        [tableScreening[0], tableScreening[1]]),
    Movie(
        2,
        'Frozen 2',
        104,
        AssetHelper.imgFrozen,
        4.7,
        '2023-12-31',
        '2023-01-01',
        [tableGenres[4], tableGenres[1]],
        'The sequel to Frozen.',
        ['Director 2'],
        ['Nguyễn Lê Văn', 'Actor 4'],
        [
          AssetHelper.imgMovieBanner,
          AssetHelper.imgMoviePoster,
        ],
        [tableScreening[0], tableScreening[2], tableScreening[3]]),
    Movie(
        3,
        'Onward',
        102,
        AssetHelper.imgOnward,
        4.2,
        '2022-10-01',
        '2022-02-01',
        [tableGenres[3], tableGenres[1]],
        'Two elf brothers go on a quest.',
        ['Director 3'],
        ['Nguyễn Lê Văn', 'Actor 6'],
        [AssetHelper.imgMoviePoster2, AssetHelper.imgMoviePoster3],
        [tableScreening[0], tableScreening[1], tableScreening[4]]),
    Movie(
        4,
        'Ralph Internet',
        110,
        AssetHelper.imgRalph,
        4.0,
        '2022-09-30',
        '2022-03-01',
        [tableGenres[2], tableGenres[1]],
        'Ralph breaks the internet.',
        ['Director 4'],
        ['Nguyễn Lê Văn', 'Actor 8'],
        [AssetHelper.imgTrailer1, AssetHelper.imgTrailer2],
        [
          tableScreening[0],
          tableScreening[5],
          tableScreening[3],
          tableScreening[1]
        ]),
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
        [
          tableScreening[5],
          tableScreening[2],
          tableScreening[1],
          tableScreening[0]
        ]),
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
        [
          tableScreening[1],
          tableScreening[2],
          tableScreening[3],
          tableScreening[0],
          tableScreening[8],
          tableScreening[9],
          tableScreening[10],
        ]),
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
      id: 2,
      name: 'Drama',
    ),
    Genre(
      id: 3,
      name: 'Horror',
    ),
    Genre(
      id: 4,
      name: 'Humorous',
    ),
    Genre(
      id: 5,
      name: 'Tail',
    ),
  ];

  static List<Screening> tableScreening = [
    Screening(
      auditorium: tableAuditorium[0],
      date: '2024-05-30',
      id: 1,
      start: '8:30',
    ),
    Screening(
      auditorium: tableAuditorium[1],
      date: '2024-05-30',
      id: 2,
      start: '9:30',
    ),
    Screening(
      auditorium: tableAuditorium[2],
      date: '2024-05-30',
      id: 3,
      start: '10:30',
    ),
    Screening(
      auditorium: tableAuditorium[3],
      date: '2024-05-30',
      id: 4,
      start: '11:30',
    ),
    Screening(
      auditorium: tableAuditorium[4],
      date: '2024-05-26',
      id: 5,
      start: '17:30',
    ),
    Screening(
      auditorium: tableAuditorium[1],
      date: '2024-05-25',
      id: 6,
      start: '20:30',
    ),
    Screening(
      auditorium: tableAuditorium[2],
      date: '2024-05-27',
      id: 7,
      start: '9:30',
    ),
    Screening(
      auditorium: tableAuditorium[5],
      date: '2024-05-28',
      id: 8,
      start: '21:30',
    ),
    Screening(
      auditorium: tableAuditorium[1],
      date: '2024-05-30',
      id: 9,
      start: '21:30',
    ),
    Screening(
      auditorium: tableAuditorium[0],
      date: '2024-05-30',
      id: 10,
      start: '21:21',
    ),
    Screening(
      auditorium: tableAuditorium[1],
      date: '2024-05-30',
      id: 11,
      start: '21:11',
    ),
  ];

  static List<Auditorium> tableAuditorium = [
    Auditorium(
      id: 1,
      name: 'A',
      cinema: tableCinema[0],
    ),
    Auditorium(
      id: 2,
      name: 'A',
      cinema: tableCinema[1],
    ),
    Auditorium(
      id: 3,
      name: 'B',
      cinema: tableCinema[2],
    ),
    Auditorium(
      id: 4,
      name: 'B',
      cinema: tableCinema[3],
    ),
    Auditorium(
      id: 5,
      name: 'C',
      cinema: tableCinema[4],
    ),
    Auditorium(
      id: 6,
      name: 'C',
      cinema: tableCinema[5],
    ),
  ];
  static List<Cinema> tableCinema = [
    Cinema(
      id: 1,
      address: tableAddress[0],
      name: 'VNPT Cinema Xuân Khánh',
    ),
    Cinema(
      id: 2,
      address: tableAddress[0],
      name: 'VNPT Cinema Hùng Vương',
    ),
    Cinema(
      id: 3,
      address: tableAddress[0],
      name: 'VNPT Cinema Hoàn Kiếm',
    ),
    Cinema(
      id: 4,
      address: tableAddress[0],
      name: 'LVNPT Cinema Lê Lợi',
    ),
    Cinema(
      id: 5,
      address: tableAddress[3],
      name: 'VNPT Cinema Nam Đẩu',
    ),
    Cinema(
      id: 6,
      address: tableAddress[2],
      name: 'VNPT Cinema Trịnh Phụng',
    ),
    Cinema(
      id: 7,
      address: tableAddress[3],
      name: 'VNPT Cinema Song Tai',
    ),
  ];

  static List<Address> tableAddress = [
    Address(id: 1, city: 'Cần Thơ', district: 'a', street: 'a', ward: 'a'),
    Address(id: 2, city: 'Hà Nội', district: 'b', street: 'b', ward: 'b'),
    Address(id: 3, city: 'TP.HCM', district: 'c', street: 'c', ward: 'c'),
    Address(id: 4, city: 'Hải Phòng', district: 'd', street: 'd', ward: 'd'),
  ];

  static List<Seat> tableSeat = [
    Seat(
        id: 1,
        numberSeat: 'A1',
        price: 49000,
        status: SeatStatus.available,
        auditorium: tableAuditorium[0]),
    Seat(
        id: 2,
        numberSeat: 'A2',
        price: 49000,
        status: SeatStatus.reserved,
        auditorium: tableAuditorium[0]),
    Seat(
        id: 3,
        numberSeat: 'A3',
        price: 100000,
        status: SeatStatus.available,
        auditorium: tableAuditorium[0]),
    Seat(
        id: 4,
        numberSeat: 'A4',
        price: 100000,
        status: SeatStatus.available,
        auditorium: tableAuditorium[0]),
    Seat(
        id: 5,
        numberSeat: 'A5',
        price: 100000,
        status: SeatStatus.available,
        auditorium: tableAuditorium[0]),
    Seat(
        id: 6,
        numberSeat: 'A6',
        price: 100000,
        status: SeatStatus.available,
        auditorium: tableAuditorium[0]),
    Seat(
        id: 7,
        numberSeat: 'A7',
        price: 100000,
        status: SeatStatus.available,
        auditorium: tableAuditorium[0]),
    Seat(
        id: 8,
        numberSeat: 'A8',
        price: 100000,
        status: SeatStatus.available,
        auditorium: tableAuditorium[0]),
    Seat(
        id: 9,
        numberSeat: 'A9',
        price: 100000,
        status: SeatStatus.available,
        auditorium: tableAuditorium[0]),
    Seat(
        id: 10,
        numberSeat: 'A10',
        price: 100000,
        status: SeatStatus.available,
        auditorium: tableAuditorium[0]),
    Seat(
        id: 11,
        numberSeat: 'B1',
        price: 100000,
        status: SeatStatus.available,
        auditorium: tableAuditorium[0]),
  ];

  static List<String> getCity() {
    return tableAddress.map((address) => address.city).toList();
  }
}
