import 'package:imdb_trending/app/core/shared/infrastructure/errors/errors.dart';

abstract class TrendingMovieErrors implements Errors{
  @override
  final String message;

  TrendingMovieErrors(this.message);
}