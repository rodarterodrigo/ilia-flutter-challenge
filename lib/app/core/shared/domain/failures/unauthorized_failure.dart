import 'package:imdb_trending/app/core/shared/domain/failures/failures.dart';

class UnauthorizedFailure implements Failures{
  @override
  final String message;

  UnauthorizedFailure(this.message);
}