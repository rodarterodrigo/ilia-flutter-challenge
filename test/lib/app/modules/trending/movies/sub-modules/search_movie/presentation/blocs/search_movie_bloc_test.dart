import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tmdb_trending/app/core/shared/domain/entities/movie_list.dart';
import 'package:tmdb_trending/app/core/shared/domain/entities/movie_list_results.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/general_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/general_failure_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/loading_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/not_found_failure_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/unauthorized_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/entities/search_movie_parameter.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/failures/search_movie_empty_query_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/failures/search_movie_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/usecases/search_movie_by_query.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/events/fetch_search_movie_event.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/events/search_movie_event.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/search_movie_bloc.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/fetch_search_movie_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/fetch_search_movie_loading_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/fetch_search_movie_success_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/search_movie_empty_query_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/search_movie_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/search_movie_success_state.dart';

class SearchMovieByQueryAbstractionMock extends Mock
    implements SearchMovieByQueryAbstraction {}

class SearchMovieParameterFake extends Fake
    implements SearchMovieParameter {}

final usecase = SearchMovieByQueryAbstractionMock();
final bloc = SearchMovieBloc(usecase);

const MovieList movieListPage = MovieList(
    results: MovieListResults(movies: []),
    page: 1,
    totalPages: 1,
    totalResults: 1);

const SearchMovieParameter filledParameter =
SearchMovieParameter(
  page: 1,
  language: 'pt-BR',
  locationLanguage: 'pt',
  searchValue: 'searchValue',
);

const SearchMovieParameter searchQueryEmptyParameter =
SearchMovieParameter(
  page: 1,
  language: 'pt-BR',
  locationLanguage: 'pt',
  searchValue: '',
);

void main() {
  setUpAll(() {
    registerFallbackValue(SearchMovieParameterFake());
  });

  test(
      'Should return all states in order and SearchMovieSuccessState as final state',
          () async {
        when(() => usecase(any()))
            .thenAnswer((invocation) async => const Right(movieListPage));
        bloc.add(const SearchMovieEvent(filledParameter));
        expect(
            bloc.stream,
            emitsInOrder(
                [isA<LoadingState>(), isA<SearchMovieSuccessState>()]));
      });

  test(
      'Should return all states in order and SearchMovieFailureState as final state',
          () async {
        when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(SearchMovieFailure('SearchMovieFailure')));
        bloc.add(const SearchMovieEvent(filledParameter));
        expect(
            bloc.stream,
            emitsInOrder(
                [isA<LoadingState>(), isA<SearchMovieFailureState>()]));
      });

  test(
      'Should return all states in order and SearchMovieEmptyQueryFailureState as final state',
          () async {
        when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(
            SearchMovieEmptyQueryFailure('SearchMovieEmptyQueryFailure')));
        bloc.add(const SearchMovieEvent(searchQueryEmptyParameter));
        expect(
            bloc.stream,
            emitsInOrder(
                [
                  isA<LoadingState>(),
                  isA<SearchMovieEmptyQueryFailureState>()
                ]));
      });

  test(
      'Should return all states in order and UnauthorizedFailureState as final state',
          () async {
        when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(UnauthorizedFailure('UnauthorizedFailure')));
        bloc.add(const SearchMovieEvent(filledParameter));
        expect(bloc.stream,
            emitsInOrder(
                [isA<LoadingState>(), isA<UnauthorizedFailureState>()]));
      });

  test(
      'Should return all states in order and NotFoundFailureState as final state',
          () async {
        when(() => usecase(any())).thenAnswer(
                (invocation) async =>
            const Left(NotFoundFailure('NotFoundFailure')));
        bloc.add(const SearchMovieEvent(filledParameter));
        expect(bloc.stream,
            emitsInOrder([isA<LoadingState>(), isA<NotFoundFailureState>()]));
      });

  test(
      'Should return all states in order and GeneralFailureState as final state',
          () async {
        when(() => usecase(any())).thenAnswer(
                (invocation) async =>
            const Left(GeneralFailure('GeneralFailure')));
        bloc.add(const SearchMovieEvent(filledParameter));
        expect(bloc.stream,
            emitsInOrder([isA<LoadingState>(), isA<GeneralFailureState>()]));
      });

  //fetch

  test(
      'Should return all states in order and FetchSearchMovieSuccessState as final state',
          () async {
        when(() => usecase(any()))
            .thenAnswer((invocation) async => const Right(movieListPage));
        bloc.add(const FetchSearchMovieEvent(filledParameter));
        expect(
            bloc.stream,
            emitsInOrder([
              isA<FetchSearchMovieLoadingState>(),
              isA<FetchSearchMovieSuccessState>()
            ]));
      });

  test(
      'Should return all states in order and FetchSearchMovieFailureState as final state',
          () async {
        when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(SearchMovieFailure('SearchMovieFailure')));
        bloc.add(const FetchSearchMovieEvent(filledParameter));
        expect(
            bloc.stream,
            emitsInOrder([
              isA<FetchSearchMovieLoadingState>(),
              isA<FetchSearchMovieFailureState>()
            ]));
      });

  test(
      'Should return all states in order and SearchMovieEmptyQueryFailureState as final state',
          () async {
        when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(
            SearchMovieEmptyQueryFailure('SearchMovieEmptyQueryFailure')));
        bloc.add(const FetchSearchMovieEvent(filledParameter));
        expect(
            bloc.stream,
            emitsInOrder([
              isA<FetchSearchMovieLoadingState>(),
              isA<SearchMovieEmptyQueryFailureState>()
            ]));
      });

  test(
      'Should return all states in order and UnauthorizedFailureState as final state',
          () async {
        when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(UnauthorizedFailure('UnauthorizedFailure')));
        bloc.add(const FetchSearchMovieEvent(filledParameter));
        expect(
            bloc.stream,
            emitsInOrder([
              isA<FetchSearchMovieLoadingState>(),
              isA<UnauthorizedFailureState>()
            ]));
      });

  test(
      'Should return all states in order and NotFoundFailureState as final state',
          () async {
        when(() => usecase(any())).thenAnswer(
                (invocation) async =>
            const Left(NotFoundFailure('NotFoundFailure')));
        bloc.add(const FetchSearchMovieEvent(filledParameter));
        expect(
            bloc.stream,
            emitsInOrder([
              isA<FetchSearchMovieLoadingState>(),
              isA<NotFoundFailureState>()
            ]));
      });

  test(
      'Should return all states in order and GeneralFailureState as final state',
          () async {
        when(() => usecase(any())).thenAnswer(
                (invocation) async =>
            const Left(GeneralFailure('GeneralFailure')));
        bloc.add(const FetchSearchMovieEvent(filledParameter));
        expect(
            bloc.stream,
            emitsInOrder([
              isA<FetchSearchMovieLoadingState>(),
              isA<GeneralFailureState>()
            ]));
      });
}