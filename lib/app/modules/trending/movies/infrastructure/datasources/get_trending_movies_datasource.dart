import 'package:imdb_trending/app/modules/trending/movies/infrastructure/models/movie_list_model.dart';

abstract class GetTrendingMoviesDatasource {
  Future<MovieListModel> call(String timeWindow, int page);
}
