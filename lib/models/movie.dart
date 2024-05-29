import 'package:movie_ticker_app_flutter/models/genre.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';

class Movie {
  final int id;
  final String title;
  final int duration;
  final String image;
  final double rating;
  final String endDate;
  final String releaseDate;
  final List<Genre> genres;
  final String description;
  final List<String> director;
  final List<String> casters;
  final List<String> trailers;
  final List<Screening> screenings;

  Movie({
    required this.id,
    required this.title,
    required this.duration,
    required this.image,
    required this.rating,
    required this.endDate,
    required this.releaseDate,
    required this.genres,
    required this.description,
    required this.director,
    required this.casters,
    required this.trailers,
    required this.screenings,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      image: json['image'],
      rating: json['rating'],
      endDate: json['endDate'],
      releaseDate: json['releaseDate'],
      genres: (json['genres'] as List).map((e) => Genre.fromJson(e)).toList(),
      description: json['description'],
      director: List<String>.from(json['director']),
      casters: List<String>.from(json['casters']),
      trailers: List<String>.from(json['trailers']),
      screenings: (json['screenings'] as List)
          .map((e) => Screening.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'image': image,
      'rating': rating,
      'endDate': endDate,
      'releaseDate': releaseDate,
      'genres': genres.map((e) => e.toJson()).toList(),
      'description': description,
      'director': director,
      'casters': casters,
      'trailers': trailers,
      'screenings': screenings.map((e) => e.toJson()).toList(),
    };
  }
}
