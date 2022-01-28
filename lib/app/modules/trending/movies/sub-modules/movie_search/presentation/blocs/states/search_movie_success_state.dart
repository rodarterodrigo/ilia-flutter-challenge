import 'package:tmdb_trending/app/core/shared/domain/entities/movie_list.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/search_movie_states.dart';

class SearchMovieSuccessState extends SearchMovieStates {
  final MovieList movieList;

  const SearchMovieSuccessState(this.movieList);
}
