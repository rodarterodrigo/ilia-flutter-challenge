import 'package:flutter_modular/flutter_modular.dart';
import 'package:imdb_trending/app/core/routes/routes.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_detail/movie_detail_module.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/usecases/get_trending_movies_by_time_window.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/external/datasources/get_trending_movies_datasource_implementation.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/infrastructure/repositories/get_trending_movies_repository_implementation.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/get_trending_movies_bloc.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/pages/trending_movies_list_page.dart';

class TrendingMoviesListModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => GetTrendingMoviesDatasourceImplementation(i())),
    Bind((i) => GetTrendingMoviesRepositoryImplementation(i())),
    Bind((i) => GetTrendingMoviesByTimeWindow(i())),
    Bind((i) => GetTrendingMoviesBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, arguments) => TrendingMoviesListPage(
              timeWindow: arguments.data,
            ),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 400)),

    ModuleRoute(Routes.movieDetailModule, module: MovieDetailModule()),
  ];
}
