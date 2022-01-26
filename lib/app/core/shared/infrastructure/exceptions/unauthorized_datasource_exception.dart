import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/general_exceptions.dart';

class UnauthorizedDatasourceException implements GeneralExceptions{
  @override
  final String message;

  UnauthorizedDatasourceException(this.message);
}