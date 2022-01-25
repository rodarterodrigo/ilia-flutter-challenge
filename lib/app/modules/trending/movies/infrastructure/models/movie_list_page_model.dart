import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie_list_page.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie_list_results.dart';

class MovieListPageModel extends MovieListPage{
  MovieListPageModel({
    required MovieListResults results,
    required int page,
    required int totalPages,
    required int totalResults,
  }):super(
    results: results,
    page: page,
    totalPages: totalPages,
    totalResults: totalResults,
  );

  factory MovieListPageModel.fromJson(Map<String, dynamic> json) =>
      MovieListPageModel(
          results: json['results'],
          page: json['page'],
          totalPages: json['total_pages'],
          totalResults: json['total_results'],
      );
}