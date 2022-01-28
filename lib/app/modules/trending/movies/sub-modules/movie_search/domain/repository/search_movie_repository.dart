import 'package:dartz/dartz.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/failures.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/movie_list.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/entities/search_movie_parameter.dart';

abstract class SearchMovieRepository{
  Future<Either<Failures, MovieList>>call(SearchMovieParameter parameter);
}