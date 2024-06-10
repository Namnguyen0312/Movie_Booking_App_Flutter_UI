import 'package:movie_ticker_app_flutter/models/response/genre_response.dart';

class MovieResponse {
  final int id;
  final String title;
  final int duration;
  final String image;
  final double rating;
  final String endDate;
  final String releaseDate;
  final List<GenreResponse> genres;
  final String description;
  final String director;
  final List<String> casts;
  final String trailers;

  MovieResponse({
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
    required this.casts,
    required this.trailers,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      trailers: json['trailer'],
      director: json['director'],
      casts: List<String>.from(json['casts']),
      duration: json['duration'],
      rating: json['rating'],
      releaseDate: json['release_date'],
      endDate: json['end_date'],
      genres: (json['genres'] as List)
          .map((e) => GenreResponse.fromJson(e))
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
      'casters': casts,
      'trailers': trailers,
    };
  }
}
