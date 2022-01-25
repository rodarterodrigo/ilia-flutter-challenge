import 'package:imdb_trending/app/core/shared/infrastructure/errors/errors.dart';

class NotFoundDatasourceError implements Errors{
  @override
  final String message;

  NotFoundDatasourceError(this.message);
}