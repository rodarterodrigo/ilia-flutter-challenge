import 'package:dartz/dartz.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/failures.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/movie_list.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/trending_movies_request_parameter.dart';

abstract class GetTrendingMoviesRepository {
  Future<Either<Failures, MovieList>> call(
      TrendingMoviesRequestParameter parameter);
}
