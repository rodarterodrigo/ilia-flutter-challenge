import 'package:tmdb_trending/app/core/shared/domain/failures/failures.dart';

abstract class GetMovieTrailerResultsFailures implements Failures{
  @override
  final String message;

  GetMovieTrailerResultsFailures(this.message);
}