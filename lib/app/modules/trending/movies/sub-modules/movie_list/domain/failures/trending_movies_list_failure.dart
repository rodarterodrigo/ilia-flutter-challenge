import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/failures/trending_movies_failures.dart';

class TrendingMoviesListFailure implements TrendingMovieFailures {
  @override
  final String message;

  const TrendingMoviesListFailure(this.message);
}
