import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/infrastructure/exceptions/trending_movies_exception.dart';

class GetTrendingMoviesListDatasourceException
    implements TrendingMovieExceptions {
  @override
  final String message;

  const GetTrendingMoviesListDatasourceException(this.message);
}
