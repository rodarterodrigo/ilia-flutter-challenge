import 'package:tmdb_trending/app/core/shared/domain/entities/movie.dart';
import 'package:tmdb_trending/app/core/shared/domain/entities/movie_list_results.dart';
import 'package:tmdb_trending/app/core/shared/infrastructure/models/movie_model.dart';

class MovieListResultsModel extends MovieListResults {
  const MovieListResultsModel({
    required List<Movie> movies,
  }) : super(
          movies: movies,
        );

  factory MovieListResultsModel.fromJson(List<dynamic> json) =>
      MovieListResultsModel(
        movies: json.map((e) => MovieModel.fronJson(e)).toList(),
      );
}
