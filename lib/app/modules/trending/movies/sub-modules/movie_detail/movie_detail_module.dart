import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb_trending/app/core/routes/routes.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_detail/presentation/pages/movie_detail_page.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/usecases/get_movie_trailer_by_movie_id.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/external/datasources/get_movie_trailer_results_datasource_implementation.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/repositories/get_movie_trailer_results_repository_implementation.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/presentation/blocs/get_movie_trailer_bloc.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/presentation/pages/movie_trailer_page.dart';

class MovieDetailModule extends Module{

  @override
  final List<Bind> binds = [
    Bind((i) => GetMovieTrailerResultsDatasourceImplementation(i())),
    Bind((i) => GetMovieTrailerResultsRepositoryImplementation(i())),
    Bind((i) => GetMovieTrailerByMovieId(i())),
    Bind((i) => GetMovieTrailerBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, arguments) => MovieDetailPage(
          movie: arguments.data,
        ),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 400)),
    ChildRoute(Routes.movieTrailerModule,
        child: (context, arguments) => MovieTrailerPage(
          videoId: arguments.data,
        ),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 400)),
  ];
}