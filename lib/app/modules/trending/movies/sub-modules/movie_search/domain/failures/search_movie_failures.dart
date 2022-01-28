import 'package:tmdb_trending/app/core/shared/domain/failures/failures.dart';

abstract class SearchMovieFailures implements Failures {
  @override
  final String message;

  const SearchMovieFailures(this.message);
}
