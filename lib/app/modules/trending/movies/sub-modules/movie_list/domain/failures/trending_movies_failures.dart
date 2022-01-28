import 'package:tmdb_trending/app/core/shared/domain/failures/failures.dart';

abstract class TrendingMovieFailures implements Failures {
  @override
  final String message;

  const TrendingMovieFailures(this.message);
}
