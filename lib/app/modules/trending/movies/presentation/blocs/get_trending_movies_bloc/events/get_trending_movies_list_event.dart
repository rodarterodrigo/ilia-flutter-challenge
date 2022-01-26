import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/events/trending_movies_list_events.dart';

class GetTrendingMoviesListEvent extends TrendingMoviesListEvents {
  final String timeWindow;
  final int page;

  const GetTrendingMoviesListEvent(this.timeWindow, this.page);
}
