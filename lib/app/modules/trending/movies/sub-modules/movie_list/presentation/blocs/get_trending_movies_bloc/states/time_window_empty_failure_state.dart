import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/failures/time_window_empty_failure.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/trending_movies_list_states.dart';

class TimeWindowEmptyFailureState extends TrendingMoviesListStates {
  final TimeWindowEmptyFailure failure;

  const TimeWindowEmptyFailureState(this.failure);
}
