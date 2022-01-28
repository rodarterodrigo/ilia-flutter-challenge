import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/movie_list_results.dart';

class MovieList {
  final MovieListResults results;
  final int page;
  final int totalPages;
  final int totalResults;

  const MovieList({
    required this.results,
    required this.page,
    required this.totalPages,
    required this.totalResults,
  });
}
