import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/failures/get_movie_trailer_results_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/presentation/blocs/states/get_movie_trailer_states.dart';

class GetMovieTrailerFailureState extends GetMovieTrailerStates{
  final GetMovieTrailerResultsFailure failure;

  GetMovieTrailerFailureState(this.failure);
}