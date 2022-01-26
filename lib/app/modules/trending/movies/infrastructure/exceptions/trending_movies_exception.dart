import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/general_exceptions.dart';

abstract class TrendingMovieExceptions implements GeneralExceptions{
  @override
  final String message;

  TrendingMovieExceptions(this.message);
}