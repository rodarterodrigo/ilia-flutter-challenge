import 'package:imdb_trending/app/core/shared/domain/failures/failures.dart';

class GeneralFailure implements Failures {
  @override
  final String message;

  const GeneralFailure(this.message);
}