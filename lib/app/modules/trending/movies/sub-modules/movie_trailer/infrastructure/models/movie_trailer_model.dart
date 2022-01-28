import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/entities/movie_trailer.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/entities/movie_trailer_results.dart';

class MovieTrailerModel extends MovieTrailer{
  MovieTrailerModel({
    required int id,
    required MovieTrailerResults movieTrailerResults,
  }):super(
    id: id,
    movieTrailerResults: movieTrailerResults,
  );

  factory MovieTrailerModel.fromJson(Map<String, dynamic> json) =>
      MovieTrailerModel(
        id: json['id'],
        movieTrailerResults: json['results'],
      );
}