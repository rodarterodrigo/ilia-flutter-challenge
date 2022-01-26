import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/generic_failure.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:imdb_trending/app/core/shared/presentation/blocs/states/generic_failure_state.dart';
import 'package:imdb_trending/app/core/shared/presentation/blocs/states/loading_state.dart';
import 'package:imdb_trending/app/core/shared/presentation/blocs/states/not_found_failure_state.dart';
import 'package:imdb_trending/app/core/shared/presentation/blocs/states/unauthorized_failure_state.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie_list_page.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie_list_results.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/failures/time_window_empty_failure.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/failures/trending_movies_list_failure.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/usecases/get_trending_movies_by_time_window.dart';
import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/events/fetch_trending_movies_list_event.dart';
import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/events/get_trending_movies_list_event.dart';
import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/get_trending_movies_bloc.dart';
import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/states/fetch_trending_movies_list_failure_state.dart';
import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/states/fetch_trending_movies_list_success_state.dart';
import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/states/fetch_trending_movies_loading_state.dart';
import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/states/get_trending_movies_list_failure_state.dart';
import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/states/get_trending_movies_list_success_state.dart';
import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/states/time_window_empty_failure_state.dart';
import 'package:mocktail/mocktail.dart';

class GetTrendingMoviesByTimeWindowAbstractionMock extends Mock
    implements GetTrendingMoviesByTimeWindowAbstraction {}

final usecase = GetTrendingMoviesByTimeWindowAbstractionMock();
final bloc = GetTrendingMoviesBloc(usecase);

const MovieListPage movieListPage = MovieListPage(
    results: MovieListResults(movies: []),
    page: 1,
    totalPages: 1,
    totalResults: 1);

void main() {
  test(
      'Should return all states in order and GetTrendingMoviesListSuccessState as final state',
      () async {
    when(() => usecase(any(), any()))
        .thenAnswer((invocation) async => const Right(movieListPage));
    bloc.add(GetTrendingMoviesListEvent('timeWindow', 1));
    expect(
        bloc.stream,
        emitsInOrder(
            [isA<LoadingState>(), isA<GetTrendingMoviesListSuccessState>()]));
  });

  test(
      'Should return all states in order and GetTrendingMoviesListFailureState as final state',
      () async {
    when(() => usecase(any(), any())).thenAnswer((invocation) async =>
        const Left(TrendingMoviesListFailure('GetTrendingMoviesListFailure')));
    bloc.add(GetTrendingMoviesListEvent('timeWindow', 1));
    expect(
        bloc.stream,
        emitsInOrder(
            [isA<LoadingState>(), isA<GetTrendingMoviesListFailureState>()]));
  });

  test(
      'Should return all states in order and TimeWindowEmptyFailureState as final state',
      () async {
    when(() => usecase(any(), any())).thenAnswer((invocation) async =>
        const Left(TimeWindowEmptyFailure('TimeWindowEmptyFailure')));
    bloc.add(GetTrendingMoviesListEvent('', 1));
    expect(
        bloc.stream,
        emitsInOrder(
            [isA<LoadingState>(), isA<TimeWindowEmptyFailureState>()]));
  });

  test(
      'Should return all states in order and UnauthorizedFailureState as final state',
      () async {
    when(() => usecase(any(), any())).thenAnswer(
        (invocation) async => Left(UnauthorizedFailure('UnauthorizedFailure')));
    bloc.add(GetTrendingMoviesListEvent('timeWindow', 1));
    expect(bloc.stream,
        emitsInOrder([isA<LoadingState>(), isA<UnauthorizedFailureState>()]));
  });

  test(
      'Should return all states in order and NotFoundFailureState as final state',
      () async {
    when(() => usecase(any(), any())).thenAnswer(
        (invocation) async => Left(NotFoundFailure('NotFoundFailure')));
    bloc.add(GetTrendingMoviesListEvent('timeWindow', 1));
    expect(bloc.stream,
        emitsInOrder([isA<LoadingState>(), isA<NotFoundFailureState>()]));
  });

  test(
      'Should return all states in order and GenericFailureState as final state',
      () async {
    when(() => usecase(any(), any())).thenAnswer(
        (invocation) async => Left(GeneralFailure('GenericFailure')));
    bloc.add(GetTrendingMoviesListEvent('timeWindow', 1));
    expect(bloc.stream,
        emitsInOrder([isA<LoadingState>(), isA<GenericFailureState>()]));
  });

  //fetch

  test(
      'Should return all states in order and GetTrendingMoviesListSuccessState as final state',
      () async {
    when(() => usecase(any(), any()))
        .thenAnswer((invocation) async => const Right(movieListPage));
    bloc.add(FetchTrendingMoviesListEvent('timeWindow', 1));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<FetchTrendingMoviesListLoadingState>(),
          isA<FetchTrendingMoviesListSuccessState>()
        ]));
  });

  test(
      'Should return all states in order and GetTrendingMoviesListFailureState as final state',
      () async {
    when(() => usecase(any(), any())).thenAnswer((invocation) async =>
        const Left(TrendingMoviesListFailure('GetTrendingMoviesListFailure')));
    bloc.add(FetchTrendingMoviesListEvent('timeWindow', 1));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<FetchTrendingMoviesListLoadingState>(),
          isA<FetchTrendingMoviesListFailureState>()
        ]));
  });

  test(
      'Should return all states in order and TimeWindowEmptyFailureState as final state',
      () async {
    when(() => usecase(any(), any())).thenAnswer((invocation) async =>
        const Left(TimeWindowEmptyFailure('TimeWindowEmptyFailure')));
    bloc.add(FetchTrendingMoviesListEvent('', 1));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<FetchTrendingMoviesListLoadingState>(),
          isA<TimeWindowEmptyFailureState>()
        ]));
  });

  test(
      'Should return all states in order and UnauthorizedFailureState as final state',
      () async {
    when(() => usecase(any(), any())).thenAnswer(
        (invocation) async => Left(UnauthorizedFailure('UnauthorizedFailure')));
    bloc.add(FetchTrendingMoviesListEvent('timeWindow', 1));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<FetchTrendingMoviesListLoadingState>(),
          isA<UnauthorizedFailureState>()
        ]));
  });

  test(
      'Should return all states in order and NotFoundFailureState as final state',
      () async {
    when(() => usecase(any(), any())).thenAnswer(
        (invocation) async => Left(NotFoundFailure('NotFoundFailure')));
    bloc.add(FetchTrendingMoviesListEvent('timeWindow', 1));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<FetchTrendingMoviesListLoadingState>(),
          isA<NotFoundFailureState>()
        ]));
  });

  test(
      'Should return all states in order and GenericFailureState as final state',
      () async {
    when(() => usecase(any(), any())).thenAnswer(
        (invocation) async => Left(GeneralFailure('GenericFailure')));
    bloc.add(FetchTrendingMoviesListEvent('timeWindow', 1));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<FetchTrendingMoviesListLoadingState>(),
          isA<GenericFailureState>()
        ]));
  });
}
