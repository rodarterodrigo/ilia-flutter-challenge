import 'package:imdb_trending/app/core/shared/domain/failures/failures.dart';

abstract class TrendingMovieFailures implements Failures{
  @override
  final String message;

  TrendingMovieFailures(this.message);
}