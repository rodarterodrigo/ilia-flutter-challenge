import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/failures/get_movie_trailer_results_failures.dart';

class GetMovieTrailerResultsFailure implements GetMovieTrailerResultsFailures{
  @override
  final String message;

  const GetMovieTrailerResultsFailure(this.message);
}