import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/general_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:tmdb_trending/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:tmdb_trending/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/entities/movie_trailer.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/failures/get_movie_trailer_results_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/datasources/get_movie_trailer_results_datasource.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/exceptions/get_movie_trailer_datasource_exception.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/models/movie_trailer_model.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/repositories/get_movie_trailer_results_repository_implementation.dart';

class GetMovieTrailerResultsDatasourceMock extends Mock
    implements GetMovieTrailerResultsDatasource {}

class MovieTrailerModelFake extends Fake implements MovieTrailerModel {}

final datasource = GetMovieTrailerResultsDatasourceMock();
final repository = GetMovieTrailerResultsRepositoryImplementation(datasource);

void main() {

  test('Must return an MovieTrailer entity', () async {
    when(() => datasource(any()))
        .thenAnswer((invocation) async => MovieTrailerModelFake());
    final result = await repository(1);
    expect(result.fold(id, id), isA<MovieTrailer>());
  });

  test('must return an GetMovieTrailerResultsFailure', () async {
    when(() => datasource(any())).thenThrow(
        const GetMovieTrailerDatasourceException(
            'GetMovieTrailerException'));
    final result = await repository(1);
    expect(result.fold(id, id), isA<GetMovieTrailerResultsFailure>());
  });

  test('must return an UnauthorizedFailure', () async {
    when(() => datasource(any())).thenThrow(
        const UnauthorizedDatasourceException('UnauthorizedDatasourceError'));
    final result = await repository(1);
    expect(result.fold(id, id), isA<UnauthorizedFailure>());
  });

  test('must return an NotFoundFailure', () async {
    when(() => datasource(any())).thenThrow(
        const NotFoundDatasourceException('NotFoundDatasourceError'));
    final result = await repository(1);
    expect(result.fold(id, id), isA<NotFoundFailure>());
  });

  test('must return an GeneralFailure', () async {
    when(() => datasource(any())).thenThrow(Exception('Exception'));
    final result = await repository(1);
    expect(result.fold(id, id), isA<GeneralFailure>());
  });
}