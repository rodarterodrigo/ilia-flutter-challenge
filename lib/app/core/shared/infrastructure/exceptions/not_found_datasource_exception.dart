import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/general_exceptions.dart';

class NotFoundDatasourceException implements GeneralExceptions {
  @override
  final String message;

  const NotFoundDatasourceException(this.message);
}
