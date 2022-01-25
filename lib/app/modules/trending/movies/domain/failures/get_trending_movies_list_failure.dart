import 'package:imdb_trending/app/modules/trending/movies/domain/failures/trending_movies_failures.dart';

class GetTrendingMoviesListFailure implements TrendingMovieFailures{
  @override
  final String message;

  GetTrendingMoviesListFailure(this.message);
}