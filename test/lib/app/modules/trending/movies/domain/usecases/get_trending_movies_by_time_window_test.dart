import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie_list_page.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/failures/time_window_empty_failure.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/repositories/get_trending_movies_repository.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/usecases/get_trending_movies_by_time_window.dart';
import 'package:mocktail/mocktail.dart';

class GetTrendingMoviesRepositoryMock extends Mock implements GetTrendingMoviesRepository{}
class MovieListPageFake extends Fake implements MovieListPage{}

final repository = GetTrendingMoviesRepositoryMock();
final usecase = GetTrendingMoviesByTimeWindow(repository);

void main(){

  test('Must return an MovieListPage entity', () async{
    when(() => repository()).thenAnswer((realInvocation) async => Right(MovieListPageFake()));
    final result = await usecase('timeWindow');
    expect(result.fold(id, id), isA<MovieListPage>());
  });

  test('Must return an TimeWindowEmptyFailure', () async{
    when(() => repository()).thenAnswer((realInvocation) async => Left(TimeWindowEmptyFailure('TimeWindowEmptyFailure')));
    final result = await usecase('');
    expect(result.fold(id, id), isA<TimeWindowEmptyFailure>());
  });

  test('Must return an UnauthorizedFailure', () async{
    when(() => repository()).thenAnswer((realInvocation) async => Left(UnauthorizedFailure('UnauthorizedFailure')));
    final result = await usecase('timeWindow');
    expect(result.fold(id, id), isA<UnauthorizedFailure>());
  });

  test('Must return an NotFoundFailure', () async{
    when(() => repository()).thenAnswer((realInvocation) async => Left(NotFoundFailure('NotFoundFailure')));
    final result = await usecase('timeWindow');
    expect(result.fold(id, id), isA<NotFoundFailure>());
  });
}