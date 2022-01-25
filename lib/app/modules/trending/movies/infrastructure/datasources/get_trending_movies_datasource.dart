import 'package:imdb_trending/app/modules/trending/movies/infrastructure/models/movie_list_page_model.dart';

abstract class GetTrendindMoviesDatasource{
  Future<MovieListPageModel> call();
}