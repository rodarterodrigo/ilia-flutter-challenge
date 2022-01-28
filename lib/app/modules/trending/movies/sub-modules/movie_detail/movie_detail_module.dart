import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_detail/presentation/pages/movie_detail_page.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/usecases/get_movie_trailer_by_movie_id.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/external/datasources/get_movie_trailer_results_datasource_implementation.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/repositories/get_movie_trailer_results_repository_implementation.dart';

class MovieDetailModule extends Module{

  @override
  final List<Bind> binds = [
    Bind((i) => GetMovieTrailerResultsDatasourceImplementation(i())),
    Bind((i) => GetMovieTrailerResultsRepositoryImplementation(i())),
    Bind((i) => GetMovieTrailerByMovieId(i())),
    // Bind((i) => GetTrendingMoviesBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, arguments) => MovieDetailPage(
          movie: arguments.data,
        ),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 400)),
  ];
}