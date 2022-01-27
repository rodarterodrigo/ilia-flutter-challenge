import 'package:dartz/dartz.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/failures.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie_list.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/trending_movies_request_parameter.dart';

abstract class GetTrendingMoviesRepository {
  Future<Either<Failures, MovieList>> call(
      TrendingMoviesRequestParameter parameter);
}
