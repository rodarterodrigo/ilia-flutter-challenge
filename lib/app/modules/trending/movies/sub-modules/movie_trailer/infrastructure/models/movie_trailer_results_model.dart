import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/entities/movie_trailer_result.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/entities/movie_trailer_results.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/models/movie_trailer_result_model.dart';

class MovieTrailerResultsModel extends MovieTrailerResults {
  MovieTrailerResultsModel({
    required List<MovieTrailerResult> results,
  }) : super(
          results: results,
        );

  factory MovieTrailerResultsModel.fromJson(List<dynamic> json) =>
      MovieTrailerResultsModel(
        results: json.map((e) => MovieTrailerResultModel.fromJson(e)).toList(),
      );
}
