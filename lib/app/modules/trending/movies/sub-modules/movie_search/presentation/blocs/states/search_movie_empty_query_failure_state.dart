import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/failures/search_movie_empty_query_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/search_movie_states.dart';

class SearchMovieEmptyQueryFailureState extends SearchMovieStates{
  final SearchMovieEmptyQueryFailure failure;

  SearchMovieEmptyQueryFailureState(this.failure);
}