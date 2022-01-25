import 'package:dartz/dartz.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/failures.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie_list_page.dart';

abstract class GetTrendingMoviesRepository{
  Future<Either<Failures, MovieListPage>> call();
}