import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tmdb_trending/app/core/packages/http_client.dart';
import 'package:tmdb_trending/app/core/packages/http_response.dart';
import 'package:tmdb_trending/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:tmdb_trending/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/external/datasources/get_movie_trailer_results_datasource_implementation.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/exceptions/get_movie_trailer_datasource_exception.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/models/movie_trailer_model.dart';

import '../mocks/get_movie_trailer_results_not_found_response.dart';
import '../mocks/get_movie_trailer_results_success_response.dart';
import '../mocks/get_movie_trailer_results_unauthorized_response.dart';

class DioClientMock extends Mock implements RequestClient {}

final requestClient = DioClientMock();
final datasource =
    GetMovieTrailerResultsDatasourceImplementation(requestClient);

void main() {
  test('Must complete the request', () {
    when(() => requestClient.get(any())).thenAnswer((realInvocation) async =>
        const HttpResponse(
            data: getMovieTrailerResultsSuccessResponse, statusCode: 200));
    final result = datasource(1);
    expect(result, completes);
  });

  test('Must return an MovieTrailerModel', () async {
    when(() => requestClient.get(any())).thenAnswer((realInvocation) async =>
        const HttpResponse(
            data: getMovieTrailerResultsSuccessResponse, statusCode: 200));
    final result = await datasource(1);
    expect(result, isA<MovieTrailerModel>());
  });

  test('Must throw an GetMovieTrailerDatasourceException', () async {
    when(() => requestClient.get(any())).thenAnswer((realInvocation) async =>
        const HttpResponse(
            data: getMovieTrailerResultsSuccessResponse, statusCode: 500));
    final result = datasource(1);
    expect(result, throwsA(isA<GetMovieTrailerDatasourceException>()));
  });

  test('Must throw an NotFoundDatasourceException', () async {
    when(() => requestClient.get(any())).thenAnswer((realInvocation) async =>
        const HttpResponse(
            data: getMovieTrailerResultsNotFoundResponse, statusCode: 404));
    final result = datasource(1);
    expect(result, throwsA(isA<NotFoundDatasourceException>()));
  });

  test('Must throw an UnauthorizedDatasourceException', () async {
    when(() => requestClient.get(any())).thenAnswer((realInvocation) async =>
        const HttpResponse(
            data: getMovieTrailerResultsUnauthorizedResponse, statusCode: 401));
    final result = datasource(1);
    expect(result, throwsA(isA<UnauthorizedDatasourceException>()));
  });

  test('Must throw an GetMovieTrailerDatasourceException', () async {
    when(() => requestClient.get(any())).thenThrow(
        const GetMovieTrailerDatasourceException(
            'GetMovieTrailerDatasourceException'));
    final result = datasource(1);
    expect(result, throwsA(isA<GetMovieTrailerDatasourceException>()));
  });

  test('Must throw an UnauthorizedDatasourceException', () async {
    when(() => requestClient.get(any())).thenThrow(
        const UnauthorizedDatasourceException(
            'UnauthorizedDatasourceException'));
    final result = datasource(1);
    expect(result, throwsA(isA<UnauthorizedDatasourceException>()));
  });

  test('Must throw an NotFoundDatasourceException', () async {
    when(() => requestClient.get(any())).thenThrow(
        const NotFoundDatasourceException('NotFoundDatasourceException'));
    final result = datasource(1);
    expect(result, throwsA(isA<NotFoundDatasourceException>()));
  });
}
