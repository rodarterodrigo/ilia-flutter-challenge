import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imdb_trending/app/core/extensions/string_translator_extension.dart';
import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/events/get_trending_movies_list_event.dart';
import 'package:imdb_trending/app/modules/trending/movies/presentation/blocs/get_trending_movies_bloc/get_trending_movies_bloc.dart';

class TrendingMoviesListPage extends StatefulWidget {
  final String timeWindow;

  const TrendingMoviesListPage({Key? key, required this.timeWindow})
      : super(key: key);

  @override
  _TrendingMoviesListPageState createState() => _TrendingMoviesListPageState();
}

class _TrendingMoviesListPageState extends State<TrendingMoviesListPage> {
  final GetTrendingMoviesBloc getTrendingMoviesBloc =
      Modular.get<GetTrendingMoviesBloc>();

  @override
  void initState() {
    getTrendingMoviesBloc.add(GetTrendingMoviesListEvent(widget.timeWindow, 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Trending Movies List Page'),
      ),
    );
  }
}
