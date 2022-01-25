import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie_list_results.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/models/movie_model.dart';

class MovieListResultsModel extends MovieListResults{
  MovieListResultsModel({
    required List<Movie> movies,
  }):super(
    movies: movies,
  );

  factory MovieListResultsModel.fromJson(Map<String, dynamic> json) =>
      MovieListResultsModel(
          movies: (json as List).map((e) => MovieModel.fronJson(e)).toList(),
      );
}