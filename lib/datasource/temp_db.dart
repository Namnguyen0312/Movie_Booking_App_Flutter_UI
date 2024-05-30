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
      id: 1,
      title: 'Dragon Training',
      duration: 100,
      image: AssetHelper.imgDragon,
      rating: 4.5,
      endDate: '2022-12-31',
      releaseDate: '2022-01-01',
      genres: [tableGenres[0], tableGenres[1]],
      description: 'A story about training dragons.',
      director: ['Director 1'],
      casters: ['Nguyễn Lê Văn', 'Actor 2'],
      trailers: [AssetHelper.imgTrailer1, AssetHelper.imgTrailer2],
      screenings: [
        tableScreening[10],
        tableScreening[11],
      ],
    ),
    Movie(
      id: 2,
      title: 'Frozen 2',
      duration: 104,
      image: AssetHelper.imgFrozen,
      rating: 4.7,
      endDate: '2023-12-31',
      releaseDate: '2023-01-01',
      genres: [tableGenres[4], tableGenres[1]],
      description: 'The sequel to Frozen.',
      director: ['Director 2'],
      casters: ['Nguyễn Lê Văn', 'Actor 4'],
      trailers: [AssetHelper.imgMovieBanner, AssetHelper.imgMoviePoster],
      screenings: [
        tableScreening[8],
        tableScreening[9],
      ],
    ),
    Movie(
      id: 3,
      title: 'Onward',
      duration: 102,
      image: AssetHelper.imgOnward,
      rating: 4.2,
      endDate: '2022-10-01',
      releaseDate: '2022-02-01',
      genres: [tableGenres[3], tableGenres[1]],
      description: 'Two elf brothers go on a quest.',
      director: ['Director 3'],
      casters: ['Nguyễn Lê Văn', 'Actor 6'],
      trailers: [AssetHelper.imgMoviePoster2, AssetHelper.imgMoviePoster3],
      screenings: [
        tableScreening[6],
        tableScreening[7],
      ],
    ),
    Movie(
      id: 4,
      title: 'Ralph Internet',
      duration: 110,
      image: AssetHelper.imgRalph,
      rating: 4.0,
      endDate: '2022-09-30',
      releaseDate: '2022-03-01',
      genres: [tableGenres[2], tableGenres[1]],
      description: 'Ralph breaks the internet.',
      director: ['Director 4'],
      casters: ['Nguyễn Lê Văn', 'Actor 8'],
      trailers: [AssetHelper.imgTrailer1, AssetHelper.imgTrailer2],
      screenings: [
        tableScreening[4],
        tableScreening[5],
      ],
    ),
    Movie(
      id: 5,
      title: 'Scoob',
      duration: 95,
      image: AssetHelper.imgScoob,
      rating: 4.5,
      endDate: '2022-11-30',
      releaseDate: '2022-04-01',
      genres: [tableGenres[0], tableGenres[1]],
      description: 'Scooby-Doo and the gang.',
      director: ['Director 5'],
      casters: ['Actor 9', 'Actor 10'],
      trailers: [AssetHelper.imgMovieBanner, AssetHelper.imgMoviePoster],
      screenings: [
        tableScreening[3],
        tableScreening[1],
      ],
    ),
    Movie(
      id: 6,
      title: 'Lab Krixi',
      duration: 120,
      image: AssetHelper.imgSpongebob,
      rating: 3.9,
      endDate: '2023-08-15',
      releaseDate: '2023-05-01',
      genres: [
        tableGenres[0],
        tableGenres[1],
        tableGenres[2],
        tableGenres[3],
      ],
      description: 'A fantasy adventure.',
      director: ['Director 6'],
      casters: ['Nguyễn Lê Văn', 'Actor 2'],
      trailers: [AssetHelper.imgMoviePoster2, AssetHelper.imgMoviePoster3],
      screenings: [
        tableScreening[0],
        tableScreening[2],
      ],
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
      date: '2024-06-04',
      id: 1,
      start: '8:30',
    ),
    Screening(
      auditorium: tableAuditorium[6],
      date: '2024-06-04',
      id: 2,
      start: '8:30',
    ),
    Screening(
      auditorium: tableAuditorium[2],
      date: '2024-06-04',
      id: 3,
      start: '10:30',
    ),
    Screening(
      auditorium: tableAuditorium[3],
      date: '2024-06-04',
      id: 4,
      start: '11:30',
    ),
    Screening(
      auditorium: tableAuditorium[4],
      date: '2024-06-04',
      id: 5,
      start: '17:30',
    ),
    Screening(
      auditorium: tableAuditorium[1],
      date: '2024-06-04',
      id: 6,
      start: '20:30',
    ),
    Screening(
      auditorium: tableAuditorium[2],
      date: '2024-06-04',
      id: 7,
      start: '12:30',
    ),
    Screening(
      auditorium: tableAuditorium[5],
      date: '2024-06-04',
      id: 8,
      start: '21:30',
    ),
    Screening(
      auditorium: tableAuditorium[1],
      date: '2024-06-04',
      id: 9,
      start: '22:30',
    ),
    Screening(
      auditorium: tableAuditorium[0],
      date: '2024-06-04',
      id: 10,
      start: '21:21',
    ),
    Screening(
      auditorium: tableAuditorium[1],
      date: '2024-06-04',
      id: 11,
      start: '21:11',
    ),
    Screening(
      auditorium: tableAuditorium[2],
      date: '2024-06-04',
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
    Auditorium(
      id: 7,
      name: 'C',
      cinema: tableCinema[0],
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
    Address(
        id: 1,
        city: 'Cần Thơ',
        district: 'Q. Ninh Kiều',
        street: 'Phan Đình Phùng',
        ward: '11111111111111111111111111111111111111111111111111111'),
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
