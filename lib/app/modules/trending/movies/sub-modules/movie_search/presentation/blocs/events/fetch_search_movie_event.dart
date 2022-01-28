import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/entities/search_movie_parameter.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/events/search_movie_events.dart';

class FetchSearchMovieEvent extends SearchMovieEvents{
  final SearchMovieParameter parameter;

  const FetchSearchMovieEvent(this.parameter);
}