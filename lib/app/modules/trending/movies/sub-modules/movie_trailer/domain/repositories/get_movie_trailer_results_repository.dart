import 'package:dartz/dartz.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/failures.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/entities/movie_trailer.dart';

abstract class GetMovieTrailerResultsRepository {
  Future<Either<Failures, MovieTrailer>> call(int movieId);
}
