import 'package:dartz/dartz.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/failures.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/entities/movie_trailer.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/repositories/get_movie_trailer_results_repository.dart';

abstract class GetMovieTrailerByMovieIdAbstraction{
  Future<Either<Failures, MovieTrailer>> call(int movieId);
}

class GetMovieTrailerByMovieId implements GetMovieTrailerByMovieIdAbstraction{
  final GetMovieTrailerResultsRepository repository;

  const GetMovieTrailerByMovieId(this.repository);

  @override
  Future<Either<Failures, MovieTrailer>> call(int movieId) async => await repository(movieId);
}