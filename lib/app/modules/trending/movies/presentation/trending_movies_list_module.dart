import 'package:flutter_modular/flutter_modular.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/usecases/get_trending_movies_by_time_window.dart';
import 'package:imdb_trending/app/modules/trending/movies/external/datasources/get_trending_movies_datasource_implementation.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/repositories/get_trending_movies_repository_implementation.dart';
import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/get_trending_movies_bloc.dart';
import 'package:imdb_trending/app/modules/trending/movies/presentation/pages/trending_movies_list_page.dart';

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
        child: (context, arguments) => const TrendingMoviesListPage(
              timeWindow: 'week',
            ),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 400)),
  ];
}
