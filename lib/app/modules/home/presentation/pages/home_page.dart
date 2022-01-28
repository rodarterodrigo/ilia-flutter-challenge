import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb_trending/app/core/routes/routes.dart';
import 'package:tmdb_trending/app/modules/home/presentation/widgets/cards/home_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TMDB Trending Movies'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Selecione qual listagem de filmes você deseja',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                HomeCard(
                    onTap: () => Modular.to
                        .pushNamed(Routes.trendingMovies, arguments: 'day'),
                    title: 'Day',
                    description: 'Lista os filmes que estão em alta hoje'),
                HomeCard(
                    onTap: () => Modular.to
                        .pushNamed(Routes.trendingMovies, arguments: 'week'),
                    title: 'Week',
                    description: 'Lista os filmes que estão em alta na semana'),
              ],
            ),
          ),
        ));
  }
}
