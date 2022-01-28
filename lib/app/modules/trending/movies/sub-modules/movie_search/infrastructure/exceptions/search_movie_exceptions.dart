import 'package:tmdb_trending/app/core/shared/infrastructure/exceptions/general_exceptions.dart';

abstract class SearchMovieExceptions implements GeneralExceptions {
  @override
  final String message;

  SearchMovieExceptions(this.message);
}
