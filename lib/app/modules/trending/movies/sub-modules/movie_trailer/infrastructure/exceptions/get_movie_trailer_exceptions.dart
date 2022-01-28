import 'package:tmdb_trending/app/core/shared/infrastructure/exceptions/general_exceptions.dart';

abstract class GetMovieTrailerExceptions implements GeneralExceptions {
  @override
  final String message;

  GetMovieTrailerExceptions(this.message);
}
