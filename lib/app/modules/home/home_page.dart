import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imdb_trending/app/core/routes/routes.dart';
import 'package:imdb_trending/app/core/shared/widgets/cards/home_card.dart';

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
    print(Platform.localeName.replaceAll('_', '-'));
    print(Platform.localeName.split('_').first);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('IMDB Trending Movies'),
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
          )),
    );
  }
}
