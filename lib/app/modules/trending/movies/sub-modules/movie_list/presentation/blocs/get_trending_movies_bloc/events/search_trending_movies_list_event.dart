import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/trending_movies_request_parameter.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/events/trending_movies_list_events.dart';

class SearchTrendingMoviesListEvent extends TrendingMoviesListEvents {
  final TrendingMoviesRequestParameter parameter;
  final String searchValue;

  const SearchTrendingMoviesListEvent(this.parameter, this.searchValue);
}