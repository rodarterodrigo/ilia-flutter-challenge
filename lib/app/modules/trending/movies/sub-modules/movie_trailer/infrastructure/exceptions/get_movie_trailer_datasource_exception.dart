import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/exceptions/get_movie_trailer_exceptions.dart';

class GetMovieTrailerDatasourceException implements GetMovieTrailerExceptions{
  @override
  final String message;

  const GetMovieTrailerDatasourceException(this.message);
}