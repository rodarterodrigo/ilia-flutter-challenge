import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/generic_failure.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie_list_page.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/failures/trending_movies_list_failure.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/datasources/get_trending_movies_datasource.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/exceptions/get_trending_movies_list_datasource_exception.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/models/movie_list_page_model.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/repositories/get_trending_movies_repository_implementation.dart';
import 'package:mocktail/mocktail.dart';

class GetTrendingMoviesDatasourceMock extends Mock
    implements GetTrendingMoviesDatasource {}

class MovieListPageModelFake extends Fake implements MovieListPageModel {}

final datasource = GetTrendingMoviesDatasourceMock();
final repository = GetTrendingMoviesRepositoryImplementation(datasource);

void main() {
  test('Must return an OrderItems entity', () async {
    when(() => datasource(any(), any()))
        .thenAnswer((invocation) async => MovieListPageModelFake());
    final result = await repository('timeWindow', 1);
    expect(result.fold(id, id), isA<MovieListPage>());
  });

  test('must return an GetTrendingMoviesListFailure', () async {
    when(() => datasource(any(), any())).thenThrow(
        GetTrendingMoviesListDatasourceException(
            'GetTrendingMoviesListDatasourceError'));
    final result = await repository('timeWindow', 1);
    expect(result.fold(id, id), isA<TrendingMoviesListFailure>());
  });

  test('must return an UnauthorizedFailure', () async {
    when(() => datasource(any(), any())).thenThrow(
        UnauthorizedDatasourceException('UnauthorizedDatasourceError'));
    final result = await repository('timeWindow', 1);
    expect(result.fold(id, id), isA<UnauthorizedFailure>());
  });

  test('must return an NotFoundFailure', () async {
    when(() => datasource(any(), any()))
        .thenThrow(NotFoundDatasourceException('NotFoundDatasourceError'));
    final result = await repository('timeWindow', 1);
    expect(result.fold(id, id), isA<NotFoundFailure>());
  });

  test('must return an GenericFailure', () async {
    when(() => datasource(any(), any())).thenThrow(Exception('Exception'));
    final result = await repository('timeWindow', 1);
    expect(result.fold(id, id), isA<GeneralFailure>());
  });
}
