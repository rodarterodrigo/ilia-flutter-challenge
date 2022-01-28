import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/failures/search_movie_failures.dart';

class SearchMovieEmptyQueryFailure implements SearchMovieFailures{
  @override
  final String message;

  const SearchMovieEmptyQueryFailure(this.message);
}