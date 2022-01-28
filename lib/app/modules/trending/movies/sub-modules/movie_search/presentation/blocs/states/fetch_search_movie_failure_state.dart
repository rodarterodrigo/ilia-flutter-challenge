import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/trending_movies_list_states.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/failures/search_movie_failure.dart';

class FetchSearchMovieFailureState extends TrendingMoviesListStates {
  final SearchMovieFailure failure;

  const FetchSearchMovieFailureState(this.failure);
}
