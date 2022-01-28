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
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/entities/movie_trailer.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/entities/movie_trailer_results.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/failures/get_movie_trailer_results_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/usecases/get_movie_trailer_by_movie_id.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/presentation/blocs/events/get_movie_trailer_event.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/presentation/blocs/get_movie_trailer_bloc.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/presentation/blocs/states/get_movie_trailer_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/presentation/blocs/states/get_movie_trailer_success_state.dart';

class GetMovieTrailerByMovieIdAbstractionMock extends Mock
    implements GetMovieTrailerByMovieIdAbstraction {}

final usecase = GetMovieTrailerByMovieIdAbstractionMock();
final bloc = GetMovieTrailerBloc(usecase);

final MovieTrailer movieTrailer =
    MovieTrailer(id: 1, movieTrailerResults: MovieTrailerResults(results: []));

void main() {
  test(
      'Should return all states in order and GetMovieTrailerSuccessState as final state',
      () async {
    when(() => usecase(any()))
        .thenAnswer((invocation) async => Right(movieTrailer));
    bloc.add(const GetMovieTrailerEvent(1));
    expect(
        bloc.stream,
        emitsInOrder(
            [isA<LoadingState>(), isA<GetMovieTrailerSuccessState>()]));
  });

  test(
      'Should return all states in order and GetMovieTrailerFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async => const Left(
        GetMovieTrailerResultsFailure('GetMovieTrailerResultsFailure')));
    bloc.add(const GetMovieTrailerEvent(1));
    expect(
        bloc.stream,
        emitsInOrder(
            [isA<LoadingState>(), isA<GetMovieTrailerFailureState>()]));
  });

  test(
      'Should return all states in order and UnauthorizedFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(UnauthorizedFailure('UnauthorizedFailure')));
    bloc.add(const GetMovieTrailerEvent(1));
    expect(bloc.stream,
        emitsInOrder([isA<LoadingState>(), isA<UnauthorizedFailureState>()]));
  });

  test(
      'Should return all states in order and NotFoundFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer(
        (invocation) async => const Left(NotFoundFailure('NotFoundFailure')));
    bloc.add(const GetMovieTrailerEvent(1));
    expect(bloc.stream,
        emitsInOrder([isA<LoadingState>(), isA<NotFoundFailureState>()]));
  });

  test(
      'Should return all states in order and GeneralFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer(
        (invocation) async => const Left(GeneralFailure('GeneralFailure')));
    bloc.add(const GetMovieTrailerEvent(1));
    expect(bloc.stream,
        emitsInOrder([isA<LoadingState>(), isA<GeneralFailureState>()]));
  });
}
