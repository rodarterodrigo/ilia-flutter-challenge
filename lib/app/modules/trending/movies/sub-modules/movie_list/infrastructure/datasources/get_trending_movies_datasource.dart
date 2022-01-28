import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/trending_movies_request_parameter.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/infrastructure/models/movie_list_model.dart';

abstract class GetTrendingMoviesDatasource {
  Future<MovieListModel> call(TrendingMoviesRequestParameter parameter);
}
