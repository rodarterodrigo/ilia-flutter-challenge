import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/movie.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/movie_list_results.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/infrastructure/models/movie_model.dart';

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