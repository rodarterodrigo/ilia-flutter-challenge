import 'package:imdb_trending/app/modules/trending/movies/infrastructure/errors/trending_movies_errors.dart';

class GetTrendingMoviesListDatasourceError implements TrendingMovieErrors{
  @override
  final String message;

  GetTrendingMoviesListDatasourceError(this.message);
}