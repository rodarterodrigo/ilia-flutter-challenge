import 'package:dartz/dartz.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/failures.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:imdb_trending/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/errors/not_found_datasource_error.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/errors/unauthorized_datasource_error.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie_list_page.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/failures/get_trending_movies_list_failure.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/repositories/get_trending_movies_repository.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/datasources/get_trending_movies_datasource.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/errors/get_trending_movies_list_datasource_error.dart';

class GetTrendingMoviesRepositoryImplementation implements GetTrendingMoviesRepository{
  final GetTrendindMoviesDatasource datasource;

  GetTrendingMoviesRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failures, MovieListPage>> call() async{
    try{
      return Right(await datasource());
    }
    on GetTrendingMoviesListDatasourceError catch(e){
      return Left(GetTrendingMoviesListFailure(e.message));
    }
    on UnauthorizedDatasourceError catch(e){
      return Left(UnauthorizedFailure(e.message));
    }
    on NotFoundDatasourceError catch(e){
      return Left(NotFoundFailure(e.message));
    }
  }
}