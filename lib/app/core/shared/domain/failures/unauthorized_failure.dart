import 'package:tmdb_trending/app/core/shared/domain/failures/failures.dart';

class UnauthorizedFailure implements Failures {
  @override
  final String message;

  const UnauthorizedFailure(this.message);
}
