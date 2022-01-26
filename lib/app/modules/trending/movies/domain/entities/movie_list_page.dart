import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie_list_results.dart';

class MovieListPage {
  final MovieListResults results;
  final int page;
  final int totalPages;
  final int totalResults;

  const MovieListPage({
    required this.results,
    required this.page,
    required this.totalPages,
    required this.totalResults,
  });
}