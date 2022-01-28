import 'package:tmdb_trending/app/core/shared/infrastructure/models/movie_list_model.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/entities/search_movie_parameter.dart';

abstract class SearchMovieDatasource{
  Future<MovieListModel>call(SearchMovieParameter parameter);
}