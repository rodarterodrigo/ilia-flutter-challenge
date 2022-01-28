import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/presentation/blocs/events/get_movie_trailer_events.dart';

class GetMovieTrailerEvent extends GetMovieTrailerEvents {
  final int movieId;

  const GetMovieTrailerEvent(this.movieId);
}
