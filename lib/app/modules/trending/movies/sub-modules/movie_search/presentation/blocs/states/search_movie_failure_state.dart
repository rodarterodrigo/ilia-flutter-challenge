import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/failures/search_movie_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/search_movie_states.dart';

class SearchMovieFailureState extends SearchMovieStates{
  final SearchMovieFailure failure;

  SearchMovieFailureState(this.failure);
}