import 'package:imdb_trending/app/core/shared/domain/failures/failures.dart';

class NotFoundFailure implements Failures{
  @override
  final String message;

  NotFoundFailure(this.message);
}