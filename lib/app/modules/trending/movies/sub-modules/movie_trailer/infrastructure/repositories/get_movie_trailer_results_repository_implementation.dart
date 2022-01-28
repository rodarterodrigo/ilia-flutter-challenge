import 'package:dartz/dartz.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/failures.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/general_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:tmdb_trending/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:tmdb_trending/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/entities/movie_trailer.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/failures/get_movie_trailer_results_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/repositories/get_movie_trailer_results_repository.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/datasources/get_movie_trailer_results_datasource.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/exceptions/get_movie_trailer_datasource_exception.dart';

class GetMovieTrailerResultsRepositoryImplementation implements GetMovieTrailerResultsRepository{
  final GetMovieTrailerResultsDatasource datasource;

  GetMovieTrailerResultsRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failures, MovieTrailer>> call(int movieId) async{
    try {
      return Right(await datasource(movieId));
    } on GetMovieTrailerDatasourceException catch (e) {
    return Left(GetMovieTrailerResultsFailure(e.message));
    } on UnauthorizedDatasourceException catch (e) {
    return Left(UnauthorizedFailure(e.message));
    } on NotFoundDatasourceException catch (e) {
    return Left(NotFoundFailure(e.message));
    } on Exception catch (e) {
    return Left(GeneralFailure(e.toString()));
    }
  }
}