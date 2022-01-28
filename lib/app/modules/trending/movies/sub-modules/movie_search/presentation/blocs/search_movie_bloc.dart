import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb_trending/app/core/shared/domain/entities/movie.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/general_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/general_failure_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/general_states.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/initial_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/loading_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/not_found_failure_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/unauthorized_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/failures/search_movie_empty_query_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/failures/search_movie_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/usecases/search_movie_by_query.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/events/fetch_search_movie_event.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/events/search_movie_event.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/events/search_movie_events.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/fetch_search_movie_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/fetch_search_movie_loading_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/fetch_search_movie_success_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/search_movie_empty_query_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/search_movie_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/search_movie_success_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvents, GeneralStates> implements Disposable{
  final SearchMovieByQueryAbstraction usecase;

  SearchMovieBloc(this.usecase) : super(const InitialState()){
    on<SearchMovieEvent>(_mapSearchMovieToState);
    on<FetchSearchMovieEvent>(_mapFetchSearchMovieToState);
  }

  List<Movie> movies = [];
  bool lastPage = false;
  int page = 1;

  @override
  void dispose() => close();

  void _mapSearchMovieToState(SearchMovieEvent event, Emitter<GeneralStates> emitter) async{
    emitter(const LoadingState());
    final result = await usecase(event.parameter);
    emitter(result.fold((l) {
      switch (l.runtimeType) {
        case UnauthorizedFailure:
          return UnauthorizedFailureState(l as UnauthorizedFailure);
        case NotFoundFailure:
          return NotFoundFailureState(l as NotFoundFailure);
        case SearchMovieEmptyQueryFailure:
          return SearchMovieEmptyQueryFailureState(l as SearchMovieEmptyQueryFailure);
        case GeneralFailure:
          return GeneralFailureState(l as GeneralFailure);
        default:
          return SearchMovieFailureState(
              l as SearchMovieFailure);
      }
    }, (r) {
      movies = r.results.movies;
      return SearchMovieSuccessState(r);
    }));
  }

  void _mapFetchSearchMovieToState(FetchSearchMovieEvent event,
      Emitter<GeneralStates> emitter) async {
    emitter(const FetchSearchMovieLoadingState());
    final result = await usecase(event.parameter);
    emitter(result.fold((l) {
      switch (l.runtimeType) {
        case UnauthorizedFailure:
          return UnauthorizedFailureState(l as UnauthorizedFailure);
        case NotFoundFailure:
          return NotFoundFailureState(l as NotFoundFailure);
        case SearchMovieEmptyQueryFailure:
          return SearchMovieEmptyQueryFailureState(l as SearchMovieEmptyQueryFailure);
        case GeneralFailure:
          return GeneralFailureState(l as GeneralFailure);
        default:
          return FetchSearchMovieFailureState(
              l as SearchMovieFailure);
      }
    }, (r) {
      if (r.results.movies.length < 20) {
        lastPage = true;
      } else {
        lastPage = false;
      }
      r.results.movies.map((e) => movies.add(e)).toList();
      return FetchSearchMovieSuccessState(r);
    }));
  }
}