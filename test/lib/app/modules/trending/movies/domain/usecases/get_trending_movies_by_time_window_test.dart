import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/general_failure.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie_list.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/failures/time_window_empty_failure.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/repositories/get_trending_movies_repository.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/usecases/get_trending_movies_by_time_window.dart';
import 'package:mocktail/mocktail.dart';

class GetTrendingMoviesRepositoryMock extends Mock
    implements GetTrendingMoviesRepository {}

class MovieListPageFake extends Fake implements MovieList {}

final repository = GetTrendingMoviesRepositoryMock();
final usecase = GetTrendingMoviesByTimeWindow(repository);

void main() {
  test('Must return an MovieListPage entity', () async {
    when(() => repository(any(), any()))
        .thenAnswer((realInvocation) async => Right(MovieListPageFake()));
    final result = await usecase('timeWindow', 1);
    expect(result.fold(id, id), isA<MovieList>());
  });

  test('Must return an TimeWindowEmptyFailure', () async {
    when(() => repository(any(), any())).thenAnswer((realInvocation) async =>
        const Left(TimeWindowEmptyFailure('TimeWindowEmptyFailure')));
    final result = await usecase('', 1);
    expect(result.fold(id, id), isA<TimeWindowEmptyFailure>());
  });

  test('Must return an UnauthorizedFailure', () async {
    when(() => repository(any(), any())).thenAnswer((realInvocation) async =>
        const Left(UnauthorizedFailure('UnauthorizedFailure')));
    final result = await usecase('timeWindow', 1);
    expect(result.fold(id, id), isA<UnauthorizedFailure>());
  });

  test('Must return an NotFoundFailure', () async {
    when(() => repository(any(), any())).thenAnswer((realInvocation) async =>
        const Left(NotFoundFailure('NotFoundFailure')));
    final result = await usecase('timeWindow', 1);
    expect(result.fold(id, id), isA<NotFoundFailure>());
  });

  test('Must return an GeneralFailure', () async {
    when(() => repository(any(), any())).thenAnswer(
        (realInvocation) async => const Left(GeneralFailure('GeneralFailure')));
    final result = await usecase('timeWindow', 1);
    expect(result.fold(id, id), isA<GeneralFailure>());
  });
}
