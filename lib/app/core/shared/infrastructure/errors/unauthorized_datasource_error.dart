import 'package:imdb_trending/app/core/shared/infrastructure/errors/errors.dart';

class UnauthorizedDatasourceError implements Errors{
  @override
  final String message;

  UnauthorizedDatasourceError(this.message);
}