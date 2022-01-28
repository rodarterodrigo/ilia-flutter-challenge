import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/general_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/general_failure_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/general_states.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/initial_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/loading_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/not_found_failure_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/unauthorized_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/entities/movie_trailer_result.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/failures/get_movie_trailer_results_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/usecases/get_movie_trailer_by_movie_id.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/presentation/blocs/events/get_movie_trailer_event.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/presentation/blocs/events/get_movie_trailer_events.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/presentation/blocs/states/get_movie_trailer_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/presentation/blocs/states/get_movie_trailer_success_state.dart';

class GetMovieTrailerBloc extends Bloc<GetMovieTrailerEvents, GeneralStates> implements Disposable{
  final GetMovieTrailerByMovieIdAbstraction usecase;

  GetMovieTrailerBloc(this.usecase) : super(const InitialState()){
    on<GetMovieTrailerEvent>(_mapGetMovieTrailerToState);
  }

  List<MovieTrailerResult> trailers = [];

  @override
  void dispose() => close();

  void _mapGetMovieTrailerToState(GetMovieTrailerEvent event, Emitter<GeneralStates> emitter) async{
    emitter(const LoadingState());
    final result = await usecase(event.movieId);
    emitter(
      result.fold((l){
        switch(l.runtimeType){
          case UnauthorizedFailure:
            return UnauthorizedFailureState(l as UnauthorizedFailure);
          case NotFoundFailure:
            return NotFoundFailureState(l as NotFoundFailure);
          case GeneralFailure:
            return GeneralFailureState(l as GeneralFailure);
          default:
            return GetMovieTrailerFailureState(
                l as GetMovieTrailerResultsFailure);
        }
      }, (r){
        trailers = r.movieTrailerResults.results;
        return GetMovieTrailerSuccessState(r);
      })
    );
  }
}