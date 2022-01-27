import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/general_failure.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie_list.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/trending_movies_request_parameter.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/failures/trending_movies_list_failure.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/datasources/get_trending_movies_datasource.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/exceptions/get_trending_movies_list_datasource_exception.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/models/movie_list_model.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/repositories/get_trending_movies_repository_implementation.dart';
import 'package:mocktail/mocktail.dart';

class GetTrendingMoviesDatasourceMock extends Mock
    implements GetTrendingMoviesDatasource {}

class MovieListPageModelFake extends Fake implements MovieListModel {}

class TrendingMoviesRequestParameterFake extends Fake
    implements TrendingMoviesRequestParameter {}

final datasource = GetTrendingMoviesDatasourceMock();
final repository = GetTrendingMoviesRepositoryImplementation(datasource);

const TrendingMoviesRequestParameter filledParameter =
    TrendingMoviesRequestParameter(
  page: 1,
  language: 'pt-BR',
  locationLanguage: 'pt',
  timeWindow: 'timeWindow',
);

void main() {
  setUpAll(() {
    registerFallbackValue(TrendingMoviesRequestParameterFake());
  });

  test('Must return an MovieList entity', () async {
    when(() => datasource(any()))
        .thenAnswer((invocation) async => MovieListPageModelFake());
    final result = await repository(filledParameter);
    expect(result.fold(id, id), isA<MovieList>());
  });

  test('must return an GetTrendingMoviesListFailure', () async {
    when(() => datasource(any())).thenThrow(
        const GetTrendingMoviesListDatasourceException(
            'GetTrendingMoviesListDatasourceError'));
    final result = await repository(filledParameter);
    expect(result.fold(id, id), isA<TrendingMoviesListFailure>());
  });

  test('must return an UnauthorizedFailure', () async {
    when(() => datasource(any())).thenThrow(
        const UnauthorizedDatasourceException('UnauthorizedDatasourceError'));
    final result = await repository(filledParameter);
    expect(result.fold(id, id), isA<UnauthorizedFailure>());
  });

  test('must return an NotFoundFailure', () async {
    when(() => datasource(any())).thenThrow(
        const NotFoundDatasourceException('NotFoundDatasourceError'));
    final result = await repository(filledParameter);
    expect(result.fold(id, id), isA<NotFoundFailure>());
  });

  test('must return an GeneralFailure', () async {
    when(() => datasource(any())).thenThrow(Exception('Exception'));
    final result = await repository(filledParameter);
    expect(result.fold(id, id), isA<GeneralFailure>());
  });
}
