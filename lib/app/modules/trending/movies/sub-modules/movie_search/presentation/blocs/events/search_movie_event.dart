import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/entities/search_movie_parameter.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/events/search_movie_events.dart';

class SearchMovieEvent extends SearchMovieEvents {
  final SearchMovieParameter parameter;

  const SearchMovieEvent(this.parameter);
}
