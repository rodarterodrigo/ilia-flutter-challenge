import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb_trending/app/core/packages/http_client.dart';
import 'package:tmdb_trending/app/core/routes/routes.dart';
import 'package:tmdb_trending/app/modules/home/home_module.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/trending_movies_list_module.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/search_movie_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Dio()),
    Bind((i) => RequestClientImplementation(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Routes.home, module: HomeModule()),
    ModuleRoute(Routes.trendingMovies, module: TrendingMoviesListModule()),
    ModuleRoute(Routes.searchMovie, module: SearchMovieModule()),
  ];
}
