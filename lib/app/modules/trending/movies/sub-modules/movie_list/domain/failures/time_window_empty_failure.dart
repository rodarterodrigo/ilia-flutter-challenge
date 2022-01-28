import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/failures/trending_movies_failures.dart';

class TimeWindowEmptyFailure implements TrendingMovieFailures {
  @override
  final String message;

  const TimeWindowEmptyFailure(this.message);
}
