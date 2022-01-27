import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdb_trending/app/core/packages/http_client.dart';
import 'package:imdb_trending/app/core/packages/http_response.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/trending_movies_request_parameter.dart';
import 'package:imdb_trending/app/modules/trending/movies/external/datasources/get_trending_movies_datasource_implementation.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/exceptions/get_trending_movies_list_datasource_exception.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/models/movie_list_model.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/get_trending_movies_datasource_not_found_response.dart';
import '../mocks/get_trending_movies_datasource_success_response.dart';
import '../mocks/get_trending_movies_datasource_unauthorized_response.dart';

class DioClientMock extends Mock implements RequestClient {}

class OptionsFake extends Fake implements Options {}

class TrendingMoviesRequestParameterFake extends Fake
    implements TrendingMoviesRequestParameter {}

final requestClient = DioClientMock();
final datasource = GetTrendingMoviesDatasourceImplementation(requestClient);

const TrendingMoviesRequestParameter filledParameter =
    TrendingMoviesRequestParameter(
  page: 1,
  language: 'pt-BR',
  locationLanguage: 'pt',
  timeWindow: 'timeWindow',
);

void main() {
  setUp(() {
    registerFallbackValue(OptionsFake());
    registerFallbackValue(TrendingMoviesRequestParameterFake());
  });

  test('Must complete the request', () {
    when(() => requestClient.get(any())).thenAnswer((realInvocation) async =>
        const HttpResponse(
            data: getTrendingMoviesDatasourceSuccessResponse, statusCode: 200));
    final result = datasource(filledParameter);
    expect(result, completes);
  });

  test('Must return an MovieListModel', () async {
    when(() => requestClient.get(any())).thenAnswer((realInvocation) async =>
        const HttpResponse(
            data: getTrendingMoviesDatasourceSuccessResponse, statusCode: 200));
    final result = await datasource(filledParameter);
    expect(result, isA<MovieListModel>());
  });

  test('Must throw an GetTrendingMoviesListDatasourceException', () async {
    when(() => requestClient.get(any())).thenAnswer((realInvocation) async =>
        const HttpResponse(
            data: getTrendingMoviesDatasourceSuccessResponse, statusCode: 500));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<GetTrendingMoviesListDatasourceException>()));
  });

  test('Must throw an NotFoundDatasourceException', () async {
    when(() => requestClient.get(any())).thenAnswer((realInvocation) async =>
        const HttpResponse(
            data: getTrendingMoviesDatasourceNotFoundResponse,
            statusCode: 404));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<NotFoundDatasourceException>()));
  });

  test('Must throw an UnauthorizedDatasourceException', () async {
    when(() => requestClient.get(any())).thenAnswer((realInvocation) async =>
        const HttpResponse(
            data: getTrendingMoviesDatasourceUnauthorizedResponse,
            statusCode: 401));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<UnauthorizedDatasourceException>()));
  });

  test('Must throw an GetTrendingMoviesListDatasourceException', () async {
    when(() => requestClient.get(any())).thenThrow(
        const GetTrendingMoviesListDatasourceException(
            'GetTrendingMoviesListDatasourceException'));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<GetTrendingMoviesListDatasourceException>()));
  });

  test('Must throw an UnauthorizedDatasourceException', () async {
    when(() => requestClient.get(any())).thenThrow(
        const UnauthorizedDatasourceException(
            'UnauthorizedDatasourceException'));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<UnauthorizedDatasourceException>()));
  });

  test('Must throw an NotFoundDatasourceException', () async {
    when(() => requestClient.get(any())).thenThrow(
        const NotFoundDatasourceException('NotFoundDatasourceException'));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<NotFoundDatasourceException>()));
  });
}
