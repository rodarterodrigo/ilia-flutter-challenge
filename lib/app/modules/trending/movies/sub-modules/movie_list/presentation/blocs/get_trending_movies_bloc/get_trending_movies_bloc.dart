import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/general_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/general_failure_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/general_states.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/loading_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/not_found_failure_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/unauthorized_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/movie.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/failures/time_window_empty_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/failures/trending_movies_list_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/usecases/get_trending_movies_by_time_window.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/events/fetch_trending_movies_list_event.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/events/get_trending_movies_list_event.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/events/trending_movies_list_events.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/fetch_trending_movies_list_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/fetch_trending_movies_list_success_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/fetch_trending_movies_loading_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/get_trending_movies_list_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/get_trending_movies_list_success_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/time_window_empty_failure_state.dart';

class GetTrendingMoviesBloc
    extends Bloc<TrendingMoviesListEvents, GeneralStates>
    implements Disposable {
  final GetTrendingMoviesByTimeWindowAbstraction usecase;

  bool lastPage = false;
  int page = 1;
  List<Movie> movies = [];

  GetTrendingMoviesBloc(this.usecase) : super(const LoadingState()) {
    on<GetTrendingMoviesListEvent>(_mapGetTrendingMoviesListToState);
    on<FetchTrendingMoviesListEvent>(_mapFetchTrendingMoviesListToState);
  }

  @override
  void dispose() => close();

  void _mapGetTrendingMoviesListToState(
      GetTrendingMoviesListEvent event, Emitter<GeneralStates> emitter) async {
    emitter(const LoadingState());
    final result = await usecase(event.parameter);
    emitter(result.fold((l) {
      switch (l.runtimeType) {
        case UnauthorizedFailure:
          return UnauthorizedFailureState(l as UnauthorizedFailure);
        case NotFoundFailure:
          return NotFoundFailureState(l as NotFoundFailure);
        case TimeWindowEmptyFailure:
          return TimeWindowEmptyFailureState(l as TimeWindowEmptyFailure);
        case GeneralFailure:
          return GeneralFailureState(l as GeneralFailure);
        default:
          return GetTrendingMoviesListFailureState(
              l as TrendingMoviesListFailure);
      }
    }, (r) {
      movies = r.results.movies;
      return GetTrendingMoviesListSuccessState(r);
    }));
  }

  void _mapFetchTrendingMoviesListToState(FetchTrendingMoviesListEvent event,
      Emitter<GeneralStates> emitter) async {
    emitter(const FetchTrendingMoviesListLoadingState());
    final result = await usecase(event.parameter);
    emitter(result.fold((l) {
      switch (l.runtimeType) {
        case UnauthorizedFailure:
          return UnauthorizedFailureState(l as UnauthorizedFailure);
        case NotFoundFailure:
          return NotFoundFailureState(l as NotFoundFailure);
        case TimeWindowEmptyFailure:
          return TimeWindowEmptyFailureState(l as TimeWindowEmptyFailure);
        case GeneralFailure:
          return GeneralFailureState(l as GeneralFailure);
        default:
          return FetchTrendingMoviesListFailureState(
              l as TrendingMoviesListFailure);
      }
    }, (r) {
      if (r.results.movies.length < 20) {
        lastPage = true;
      } else {
        lastPage = false;
      }
      r.results.movies.map((e) => movies.add(e)).toList();
      return FetchTrendingMoviesListSuccessState(r);
    }));
  }
}
