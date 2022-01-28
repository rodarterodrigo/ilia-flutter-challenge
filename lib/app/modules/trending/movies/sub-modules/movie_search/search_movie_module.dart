import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/usecases/search_movie_by_query.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/external/datasources/search_movie_datasource_implementation.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/infrastructure/repositories/search_movie_repository_implementation.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/search_movie_bloc.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/pages/search_movie_page.dart';

class SearchMovieModule extends Module{
  @override
  final List<Bind> binds = [
    Bind((i) => SearchMovieDatasourceImplementation(i())),
    Bind((i) => SearchMovieRepositoryImplementation(i())),
    Bind((i) => SearchMovieByQuery(i())),
    Bind((i) => SearchMovieBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, arguments) => SearchMoviePage(),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 400)),
  ];
}