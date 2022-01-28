import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/infrastructure/exceptions/search_movie_exceptions.dart';

class SearchMovieDatasourceException implements SearchMovieExceptions {
  @override
  final String message;

  const SearchMovieDatasourceException(this.message);
}
