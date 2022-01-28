import 'package:dartz/dartz.dart';
import 'package:tmdb_trending/app/core/shared/domain/entities/movie_list.dart';
import 'package:tmdb_trending/app/core/shared/domain/failures/failures.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/entities/search_movie_parameter.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/failures/search_movie_empty_query_failure.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/repository/search_movie_repository.dart';

abstract class SearchMovieByQueryAbstraction {
  Future<Either<Failures, MovieList>> call(SearchMovieParameter parameter);
}

class SearchMovieByQuery implements SearchMovieByQueryAbstraction {
  final SearchMovieRepository repository;

  SearchMovieByQuery(this.repository);

  @override
  Future<Either<Failures, MovieList>> call(
          SearchMovieParameter parameter) async =>
      parameter.searchValue.isEmpty
          ? const Left(SearchMovieEmptyQueryFailure('Digite algo para buscar'))
          : await repository(parameter);
}
