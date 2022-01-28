import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmdb_trending/app/core/config/config.dart';
import 'package:tmdb_trending/app/core/helpers/date_time_helper.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_list/domain/entities/movie.dart';
import 'package:unicons/unicons.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      child: SizedBox(
                        width: 440,
                        child: Hero(
                          tag: movie.title,
                          child: CachedNetworkImage(
                            imageUrl: '${ServerConfiguration.serverImages}${movie.posterPath}',
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
                                  movie.title,
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
                                    child: const Icon(UniconsSolid.star, color: Colors.amber, size: 18)
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  movie.voteAverage.toString(),
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
                            Text(
                              DateTimeHelper.convertDateFromString(movie.releaseDate),
                              maxLines: 2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: SizedBox(
                            child: Text(
                              movie.overview,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 99,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
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
