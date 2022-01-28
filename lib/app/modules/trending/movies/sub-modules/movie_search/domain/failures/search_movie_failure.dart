import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/failures/search_movie_failures.dart';

class SearchMovieFailure implements SearchMovieFailures{
  @override
  final String message;

  const SearchMovieFailure(this.message);
}