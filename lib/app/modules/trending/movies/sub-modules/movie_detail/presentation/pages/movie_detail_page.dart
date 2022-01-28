import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmdb_trending/app/core/config/config.dart';
import 'package:tmdb_trending/app/core/helpers/date_time_helper.dart';
import 'package:tmdb_trending/app/core/routes/routes.dart';
import 'package:tmdb_trending/app/core/shared/presentation/blocs/states/general_states.dart';
import 'package:tmdb_trending/app/core/shared/presentation/widgets/buttons/medium_button.dart';
import 'package:tmdb_trending/app/core/shared/domain/entities/movie.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/presentation/blocs/events/get_movie_trailer_event.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/presentation/blocs/get_movie_trailer_bloc.dart';
import 'package:unicons/unicons.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final GetMovieTrailerBloc getMovieTrailerBloc =
      Modular.get<GetMovieTrailerBloc>();

  @override
  void initState() {
    getMovieTrailerBloc.add(GetMovieTrailerEvent(widget.movie.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.movie.releaseDate);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: widget.movie.posterPath.isEmpty?
                      const SizedBox():
                      SizedBox(
                        width: 440,
                        child: Hero(
                          tag: '${widget.movie.title}${ServerConfiguration.serverImages}${widget.movie.posterPath}',
                          child: CachedNetworkImage(
                            imageUrl:
                                '${ServerConfiguration.serverImages}${widget.movie.posterPath}',
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 320,
                              child: Text(
                                widget.movie.title,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Shimmer.fromColors(
                                    highlightColor: Colors.white,
                                    baseColor: Colors.amber,
                                    child: const Icon(UniconsSolid.star,
                                        color: Colors.amber, size: 18)),
                                const SizedBox(height: 2),
                                Text(
                                  widget.movie.voteAverage.toString(),
                                  style: const TextStyle(
                                    color: Colors.amber,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 16),
                            widget.movie.releaseDate.isEmpty?
                                const SizedBox():
                            Text(
                              DateTimeHelper.convertDateFromString(
                                  widget.movie.releaseDate),
                              maxLines: 2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 16),
                            BlocBuilder<GetMovieTrailerBloc, GeneralStates>(
                              bloc: getMovieTrailerBloc,
                              builder:(context, state) => getMovieTrailerBloc.trailers.isEmpty?
                              const SizedBox():
                                  MediumButton(
                                onPressed: () => Modular.to.pushNamed(
                                    Routes.movieTrailer,
                                    arguments:
                                        getMovieTrailerBloc.trailers.first.key),
                                text: 'Trailer',
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          child: Text(
                            widget.movie.overview,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 99,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
