import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb_trending/app/core/config/config.dart';
import 'package:tmdb_trending/app/core/routes/routes.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/general_failure_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/general_states.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/loading_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/not_found_failure_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/unauthorized_failure_state.dart';
import 'package:tmdb_trending/app/core/shared/presentation/widgets/dialogs/generic_dialog.dart';
import 'package:tmdb_trending/app/core/shared/presentation/widgets/inputs/custom_input_text.dart';
import 'package:tmdb_trending/app/core/shared/presentation/widgets/list_view_helpers/disable_splash.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/fetch_trending_movies_list_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/get_trending_movies_list_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/blocs/get_trending_movies_bloc/states/time_window_empty_failure_state.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/widgets/card_shimmers/list_card_shimmer.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/presentation/widgets/cards/movie_list_card.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/entities/search_movie_parameter.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/events/fetch_search_movie_event.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/events/search_movie_event.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/search_movie_bloc.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/presentation/blocs/states/fetch_search_movie_loading_state.dart';
import 'package:unicons/unicons.dart';

class SearchMoviePage extends StatelessWidget {
  SearchMoviePage({Key? key}) : super(key: key);

  final SearchMovieBloc searchMovieBloc = Modular.get<SearchMovieBloc>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Buscar filmes', maxLines: 2),
      ),
      body: SafeArea(
          child: Center(
            child: DisableSplash(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomInputText(
                        fillColor: Theme.of(context).primaryColor,
                        onChanged: (value) =>
                            searchMovieBloc.add(SearchMovieEvent(
                              SearchMovieParameter(
                                page: searchMovieBloc.page,
                                language: Platform.localeName.replaceAll('_', '-'),
                                locationLanguage: Platform.localeName.split('_').first,
                                searchValue: searchController.text,
                              ),
                            )),
                        controller: searchController,
                        sufixIcon: UniconsLine.search_alt,
                        label: 'Buscar',
                        borderRadius: 4,
                      ),
                    ),
                    BlocConsumer<SearchMovieBloc, GeneralStates>(
                        bloc: searchMovieBloc,
                        builder: (context, state) {
                          if (state is LoadingState) {
                            return Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                              ),
                              height: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                                  ? MediaQuery.of(context).size.height * 0.75
                                  : MediaQuery.of(context).size.height * 0.6,
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                  const ListCardShimmer(),
                                  separatorBuilder: (context, index) =>
                                  const SizedBox(),
                                  itemCount: 20),
                            );
                          }
                          return searchMovieBloc.movies.isEmpty
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SvgPicture.asset('assets/images/empty_svg.svg'),
                              const SizedBox(
                                height: 32,
                              ),
                              Center(
                                child: Text(
                                  'Não há items para listar',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          )
                              : NotificationListener<ScrollNotification>(
                            onNotification: (scrollInfo) {
                              if (scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                                if (!searchMovieBloc.lastPage) {
                                  searchMovieBloc.page++;
                                  searchMovieBloc.lastPage = true;
                                  searchMovieBloc.add(
                                    FetchSearchMovieEvent(
                                      SearchMovieParameter(
                                        page: searchMovieBloc.page,
                                        language: Platform.localeName
                                            .replaceAll('_', '-'),
                                        locationLanguage: Platform.localeName
                                            .split('_')
                                            .first,
                                        searchValue: searchController.text,
                                      ),
                                    ),
                                  );
                                }
                              }
                              return true;
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context)
                                      .orientation ==
                                      Orientation.portrait
                                      ? MediaQuery.of(context).size.height *
                                      0.75
                                      : MediaQuery.of(context).size.height *
                                      0.6,
                                  child: RefreshIndicator(
                                    color: Theme.of(context).highlightColor,
                                    onRefresh: () async {
                                      searchMovieBloc.page = 1;
                                      searchMovieBloc.lastPage = false;
                                      searchMovieBloc.add(
                                        SearchMovieEvent(
                                          SearchMovieParameter(
                                            page: searchMovieBloc.page,
                                            language: Platform.localeName
                                                .replaceAll('_', '-'),
                                            locationLanguage: Platform
                                                .localeName
                                                .split('_')
                                                .first,
                                            searchValue: searchController.text,
                                          ),
                                        ),
                                      );
                                    },
                                    child: DisableSplash(
                                      child: ListView.separated(
                                          physics:
                                          const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            if (state
                                            is FetchSearchMovieLoadingState) {
                                              return const ListCardShimmer();
                                            }
                                            return MovieListCard(
                                              onTap: () => Modular.to
                                                  .pushNamed(
                                                  Routes.movieDetail,
                                                  arguments:
                                                  searchMovieBloc
                                                      .movies[index]),
                                              imagePath:
                                              searchMovieBloc.movies[index].posterPath.isEmpty? '':
                                              '${ServerConfiguration.serverImages}${searchMovieBloc.movies[index].posterPath}',
                                              title: searchMovieBloc
                                                  .movies[index].title,
                                              voteAverage:
                                              searchMovieBloc
                                                  .movies[index]
                                                  .voteAverage,
                                              overview: searchMovieBloc
                                                  .movies[index].overview,
                                            );
                                          },
                                          separatorBuilder:
                                              (context, index) =>
                                          const SizedBox(),
                                          itemCount: searchMovieBloc
                                              .movies.length),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        listener: (context, state) {
                          switch (state.runtimeType) {
                            case NotFoundFailureState:
                              return GenericDialog.showGenericDialog(
                                context: context,
                                isError: true,
                                onPressed: () => Modular.to.pop(),
                                message:
                                (state as NotFoundFailureState).failure.message,
                                title: 'Erro!',
                              );
                            case UnauthorizedFailureState:
                              return GenericDialog.showGenericDialog(
                                context: context,
                                isError: true,
                                onPressed: () => Modular.to.pop(),
                                message: (state as UnauthorizedFailureState)
                                    .failure
                                    .message,
                                title: 'Erro!',
                              );
                            case GetTrendingMoviesListFailureState:
                              return GenericDialog.showGenericDialog(
                                context: context,
                                isError: true,
                                onPressed: () => Modular.to.pop(),
                                message:
                                (state as GetTrendingMoviesListFailureState)
                                    .failure
                                    .message,
                                title: 'Erro!',
                              );
                            case FetchTrendingMoviesListFailureState:
                              return GenericDialog.showGenericDialog(
                                context: context,
                                isError: true,
                                onPressed: () => Modular.to.pop(),
                                message:
                                (state as FetchTrendingMoviesListFailureState)
                                    .failure
                                    .message,
                                title: 'Erro!',
                              );
                            case GeneralFailureState:
                              return GenericDialog.showGenericDialog(
                                context: context,
                                isError: true,
                                onPressed: () => Modular.to.pop(),
                                message:
                                (state as GeneralFailureState).failure.message,
                                title: 'Erro!',
                              );
                            case TimeWindowEmptyFailureState:
                              return GenericDialog.showGenericDialog(
                                context: context,
                                isError: true,
                                onPressed: () => Modular.to.pop(),
                                message: (state as TimeWindowEmptyFailureState)
                                    .failure
                                    .message,
                                title: 'Erro!',
                              );
                          }
                        }),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
