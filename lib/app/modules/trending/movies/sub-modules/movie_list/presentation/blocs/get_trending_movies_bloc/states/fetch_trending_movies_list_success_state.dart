import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/movie_list.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/trending_movies_list_states.dart';

class FetchTrendingMoviesListSuccessState extends TrendingMoviesListStates {
  final MovieList movieListPage;

  const FetchTrendingMoviesListSuccessState(this.movieListPage);
}
