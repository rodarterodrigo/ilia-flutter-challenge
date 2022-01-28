import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/domain/entities/movie_trailer.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/presentation/blocs/states/get_movie_trailer_states.dart';

class GetMovieTrailerSuccessState extends GetMovieTrailerStates {
  final MovieTrailer movieTrailer;

  const GetMovieTrailerSuccessState(this.movieTrailer);
}
