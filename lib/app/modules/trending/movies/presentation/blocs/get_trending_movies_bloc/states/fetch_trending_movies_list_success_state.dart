import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie_list_page.dart';
import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/states/trending_movies_list_states.dart';

class FetchTrendingMoviesListSuccessState extends TrendingMoviesListStates {
  final MovieListPage movieListPage;

  const FetchTrendingMoviesListSuccessState(this.movieListPage);
}
