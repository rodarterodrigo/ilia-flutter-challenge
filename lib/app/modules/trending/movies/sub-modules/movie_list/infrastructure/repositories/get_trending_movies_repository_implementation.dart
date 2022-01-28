import 'package:dartz/dartz.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/failures.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/general_failure.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/movie_list.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/trending_movies_request_parameter.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/failures/trending_movies_list_failure.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/repositories/get_trending_movies_repository.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/infrastructure/datasources/get_trending_movies_datasource.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/infrastructure/exceptions/get_trending_movies_list_datasource_exception.dart';

class GetTrendingMoviesRepositoryImplementation
    implements GetTrendingMoviesRepository {
  final GetTrendingMoviesDatasource datasource;

  const GetTrendingMoviesRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failures, MovieList>> call(
      TrendingMoviesRequestParameter parameter) async {
    try {
      return Right(await datasource(parameter));
    } on GetTrendingMoviesListDatasourceException catch (e) {
      return Left(TrendingMoviesListFailure(e.message));
    } on UnauthorizedDatasourceException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } on NotFoundDatasourceException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on Exception catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
