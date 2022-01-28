import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/general_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/general_failure_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/loading_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/not_found_failure_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/unauthorized_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/movie_list.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/movie_list_results.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/trending_movies_request_parameter.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/failures/time_window_empty_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/failures/trending_movies_list_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/usecases/get_trending_movies_by_time_window.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/events/fetch_trending_movies_list_event.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/events/get_trending_movies_list_event.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/events/search_trending_movies_list_event.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/get_trending_movies_bloc.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/fetch_trending_movies_list_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/fetch_trending_movies_list_success_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/fetch_trending_movies_loading_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/get_trending_movies_list_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/get_trending_movies_list_success_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/search_trending_movies_list_success_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/time_window_empty_failure_state.dart';

class GetTrendingMoviesByTimeWindowAbstractionMock extends Mock
    implements GetTrendingMoviesByTimeWindowAbstraction {}

class TrendingMoviesRequestParameterFake extends Fake
    implements TrendingMoviesRequestParameter {}

final usecase = GetTrendingMoviesByTimeWindowAbstractionMock();
final bloc = GetTrendingMoviesBloc(usecase);

const MovieList movieListPage = MovieList(
    results: MovieListResults(movies: []),
    page: 1,
    totalPages: 1,
    totalResults: 1);

const TrendingMoviesRequestParameter filledParameter =
    TrendingMoviesRequestParameter(
  page: 1,
  language: 'pt-BR',
  locationLanguage: 'pt',
  timeWindow: 'timeWindow',
);

const TrendingMoviesRequestParameter timeWindowEmptyParameter =
    TrendingMoviesRequestParameter(
  page: 1,
  language: 'pt-BR',
  locationLanguage: 'pt',
  timeWindow: '',
);

void main() {
  setUpAll(() {
    registerFallbackValue(TrendingMoviesRequestParameterFake());
  });

  test(
      'Should return all states in order and GetTrendingMoviesListSuccessState as final state',
      () async {
    when(() => usecase(any()))
        .thenAnswer((invocation) async => const Right(movieListPage));
    bloc.add(const GetTrendingMoviesListEvent(filledParameter));
    expect(
        bloc.stream,
        emitsInOrder(
            [isA<LoadingState>(), isA<GetTrendingMoviesListSuccessState>()]));
  });

  test(
      'Should return all states in order and GetTrendingMoviesListFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(TrendingMoviesListFailure('GetTrendingMoviesListFailure')));
    bloc.add(const GetTrendingMoviesListEvent(filledParameter));
    expect(
        bloc.stream,
        emitsInOrder(
            [isA<LoadingState>(), isA<GetTrendingMoviesListFailureState>()]));
  });

  test(
      'Should return all states in order and TimeWindowEmptyFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(TimeWindowEmptyFailure('TimeWindowEmptyFailure')));
    bloc.add(const GetTrendingMoviesListEvent(timeWindowEmptyParameter));
    expect(
        bloc.stream,
        emitsInOrder(
            [isA<LoadingState>(), isA<TimeWindowEmptyFailureState>()]));
  });

  test(
      'Should return all states in order and UnauthorizedFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(UnauthorizedFailure('UnauthorizedFailure')));
    bloc.add(const GetTrendingMoviesListEvent(filledParameter));
    expect(bloc.stream,
        emitsInOrder([isA<LoadingState>(), isA<UnauthorizedFailureState>()]));
  });

  test(
      'Should return all states in order and NotFoundFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer(
        (invocation) async => const Left(NotFoundFailure('NotFoundFailure')));
    bloc.add(const GetTrendingMoviesListEvent(filledParameter));
    expect(bloc.stream,
        emitsInOrder([isA<LoadingState>(), isA<NotFoundFailureState>()]));
  });

  test(
      'Should return all states in order and GeneralFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer(
        (invocation) async => const Left(GeneralFailure('GeneralFailure')));
    bloc.add(const GetTrendingMoviesListEvent(filledParameter));
    expect(bloc.stream,
        emitsInOrder([isA<LoadingState>(), isA<GeneralFailureState>()]));
  });

  //fetch

  test(
      'Should return all states in order and GetTrendingMoviesListSuccessState as final state',
      () async {
    when(() => usecase(any()))
        .thenAnswer((invocation) async => const Right(movieListPage));
    bloc.add(const FetchTrendingMoviesListEvent(filledParameter));
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
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(TrendingMoviesListFailure('GetTrendingMoviesListFailure')));
    bloc.add(const FetchTrendingMoviesListEvent(filledParameter));
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
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(TimeWindowEmptyFailure('TimeWindowEmptyFailure')));
    bloc.add(const FetchTrendingMoviesListEvent(timeWindowEmptyParameter));
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
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(UnauthorizedFailure('UnauthorizedFailure')));
    bloc.add(const FetchTrendingMoviesListEvent(filledParameter));
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
    when(() => usecase(any())).thenAnswer(
        (invocation) async => const Left(NotFoundFailure('NotFoundFailure')));
    bloc.add(const FetchTrendingMoviesListEvent(filledParameter));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<FetchTrendingMoviesListLoadingState>(),
          isA<NotFoundFailureState>()
        ]));
  });

  test(
      'Should return all states in order and GeneralFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer(
        (invocation) async => const Left(GeneralFailure('GeneralFailure')));
    bloc.add(const FetchTrendingMoviesListEvent(filledParameter));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<FetchTrendingMoviesListLoadingState>(),
          isA<GeneralFailureState>()
        ]));
  });

  //search

  test(
      'Should return all states in order and SearchTrendingMoviesListSuccessState as final state',
          () async {
        when(() => usecase(any()))
            .thenAnswer((invocation) async => const Right(movieListPage));
        bloc.add(const SearchTrendingMoviesListEvent(filledParameter, 'search'));
        expect(
            bloc.stream,
            emitsInOrder([
              isA<LoadingState>(),
              isA<SearchTrendingMoviesListSuccessState>()
            ]));
      });

  test(
      'Should return all states in order and GetTrendingMoviesListFailureState as final state',
          () async {
        when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(TrendingMoviesListFailure('GetTrendingMoviesListFailure')));
        bloc.add(const SearchTrendingMoviesListEvent(filledParameter, 'search'));
        expect(
            bloc.stream,
            emitsInOrder([
              isA<LoadingState>(),
              isA<GetTrendingMoviesListFailureState>()
            ]));
      });

  test(
      'Should return all states in order and TimeWindowEmptyFailureState as final state',
          () async {
        when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(TimeWindowEmptyFailure('TimeWindowEmptyFailure')));
        bloc.add(const SearchTrendingMoviesListEvent(filledParameter, 'search'));
        expect(
            bloc.stream,
            emitsInOrder([
              isA<LoadingState>(),
              isA<TimeWindowEmptyFailureState>()
            ]));
      });

  test(
      'Should return all states in order and UnauthorizedFailureState as final state',
          () async {
        when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(UnauthorizedFailure('UnauthorizedFailure')));
        bloc.add(const SearchTrendingMoviesListEvent(filledParameter, 'search'));
        expect(
            bloc.stream,
            emitsInOrder([
              isA<LoadingState>(),
              isA<UnauthorizedFailureState>()
            ]));
      });

  test(
      'Should return all states in order and NotFoundFailureState as final state',
          () async {
        when(() => usecase(any())).thenAnswer(
                (invocation) async => const Left(NotFoundFailure('NotFoundFailure')));
        bloc.add(const SearchTrendingMoviesListEvent(filledParameter, 'search'));
        expect(
            bloc.stream,
            emitsInOrder([
              isA<LoadingState>(),
              isA<NotFoundFailureState>()
            ]));
      });

  test(
      'Should return all states in order and GeneralFailureState as final state',
          () async {
        when(() => usecase(any())).thenAnswer(
                (invocation) async => const Left(GeneralFailure('GeneralFailure')));
        bloc.add(const SearchTrendingMoviesListEvent(filledParameter, 'search'));
        expect(
            bloc.stream,
            emitsInOrder([
              isA<LoadingState>(),
              isA<GeneralFailureState>()
            ]));
      });
}
