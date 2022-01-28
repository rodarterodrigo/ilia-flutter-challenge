import 'package:flutter_modular/flutter_modular.dart';
import 'package:imdb_trending/app/modules/trending/movies/sub-modules/movie_detail/presentation/pages/movie_detail_page.dart';

class MovieDetailModule extends Module{

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