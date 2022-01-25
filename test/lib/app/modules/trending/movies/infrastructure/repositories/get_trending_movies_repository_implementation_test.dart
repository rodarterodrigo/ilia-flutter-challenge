import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/errors/not_found_datasource_error.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/errors/unauthorized_datasource_error.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie_list_page.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/failures/get_trending_movies_list_failure.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/datasources/get_trending_movies_datasource.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/errors/get_trending_movies_list_datasource_error.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/models/movie_list_page_model.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/repositories/get_trending_movies_repository_implementation.dart';
import 'package:mocktail/mocktail.dart';

class GetTrendindMoviesDatasourceMock extends Mock implements GetTrendindMoviesDatasource{}
class MovieListPageModelFake extends Fake implements MovieListPageModel{}

final datasource = GetTrendindMoviesDatasourceMock();
final repository = GetTrendingMoviesRepositoryImplementation(datasource);

void main(){

  test('Must return an OrderItems entity', () async{
    when(() => datasource()).thenAnswer((invocation) async => MovieListPageModelFake());
    final result = await repository();
    expect(result.fold(id, id), isA<MovieListPage>());
  });

  test('must return an GetTrendingMoviesListFailure', () async{
    when(() => datasource()).thenThrow(GetTrendingMoviesListDatasourceError('GetTrendingMoviesListDatasourceError'));
    final result = await repository();
    expect(result.fold(id, id), isA<GetTrendingMoviesListFailure>());
  });

  test('must return an UnauthorizedFailure', () async{
    when(() => datasource()).thenThrow(UnauthorizedDatasourceError('UnauthorizedDatasourceError'));
    final result = await repository();
    expect(result.fold(id, id), isA<UnauthorizedFailure>());
  });

  test('must return an NotFoundFailure', () async{
    when(() => datasource()).thenThrow(NotFoundDatasourceError('NotFoundDatasourceError'));
    final result = await repository();
    expect(result.fold(id, id), isA<NotFoundFailure>());
  });
}