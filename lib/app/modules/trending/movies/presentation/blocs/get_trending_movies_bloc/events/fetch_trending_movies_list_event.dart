import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/events/trending_movies_list_events.dart';

class FetchTrendingMoviesListEvent extends TrendingMoviesListEvents {
  final String timeWindow;
  final int page;

  const FetchTrendingMoviesListEvent(this.timeWindow, this.page);
}
