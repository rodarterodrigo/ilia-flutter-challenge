import 'package:imdb_trending/app/core/shared/domain/failures/failures.dart';

class GenericFailure implements Failures{
  @override
  final String message;

  GenericFailure(this.message);
}