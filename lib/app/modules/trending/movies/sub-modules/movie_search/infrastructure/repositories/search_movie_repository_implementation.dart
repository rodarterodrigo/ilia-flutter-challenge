import 'package:dartz/dartz.dart';
import 'package:tmdb_trending/app/core/shared/domain/entities/movie_list.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/failures.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/general_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:tmdb_trending/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:tmdb_trending/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/entities/search_movie_parameter.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/failures/search_movie_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/repository/search_movie_repository.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/infrastructure/datasources/search_movie_datasource.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/infrastructure/exceptions/search_movie_datasource_exception.dart';

class SearchMovieRepositoryImplementation implements SearchMovieRepository {
  final SearchMovieDatasource datasource;

  SearchMovieRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failures, MovieList>> call(
      SearchMovieParameter parameter) async {
    try {
      return Right(await datasource(parameter));
    } on SearchMovieDatasourceException catch (e) {
      return Left(SearchMovieFailure(e.message));
    } on UnauthorizedDatasourceException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } on NotFoundDatasourceException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on Exception catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
