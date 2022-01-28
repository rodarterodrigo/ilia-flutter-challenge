import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/models/movie_trailer_model.dart';

abstract class GetMovieTrailerResultsDatasource {
  Future<MovieTrailerModel> call(int movieId);
}
