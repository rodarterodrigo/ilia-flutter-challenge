import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/entities/movie_trailer_results.dart';

class MovieTrailer{
  final int id;
  final MovieTrailerResults movieTrailerResults;

  MovieTrailer({required this.id, required this.movieTrailerResults});
}