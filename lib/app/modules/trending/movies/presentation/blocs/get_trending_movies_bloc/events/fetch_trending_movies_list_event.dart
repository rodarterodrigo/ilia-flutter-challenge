import 'package:imdb_trending/app/modules/trending/movies/domain/entities/trending_movies_request_parameter.dart';
import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/events/trending_movies_list_events.dart';

class FetchTrendingMoviesListEvent extends TrendingMoviesListEvents {
  final TrendingMoviesRequestParameter parameter;

  const FetchTrendingMoviesListEvent(this.parameter);
}
