import 'package:imdb_trending/app/modules/trending/movies/domain/entities/movie.dart';

class MovieModel extends Movie{
  MovieModel({
    required String releaseDate,
    required String originalLanguage,
    required int id,
    required String posterPath,
    required bool haveVideo,
    required double voteAverage,
    required String title,
    required int voteCount,
    required List<int> genreIds,
    required String originalTitle,
    required String backdropPath,
    required bool isAdult,
    required String overview,
    required double popularity,
    required String mediaType,
  }):super(
    releaseDate: releaseDate,
    originalLanguage: originalLanguage,
    id: id,
    posterPath: posterPath,
    haveVideo: haveVideo,
    voteAverage: voteAverage,
    title: title,
    voteCount: voteCount,
    genreIds: genreIds,
    originalTitle: originalTitle,
    backdropPath: backdropPath,
    isAdult: isAdult,
    overview: overview,
    popularity: popularity,
    mediaType: mediaType,
  );

  factory MovieModel.fronJson(Map<String, dynamic> json) =>
      MovieModel(
          releaseDate: json['release_date'],
          originalLanguage: json['original_language'],
          id: json['id'],
          posterPath: json['poster_path'],
          haveVideo: json['video'],
          voteAverage: json['vote_average'],
          title: json['title'],
          voteCount: json['vote_count'],
          genreIds: (json['genre_ids'] as List<int>).map((e) => e).toList(),
          originalTitle: json['original_title'],
          backdropPath: json['backdrop_path'],
          isAdult: json['adult'],
          overview: json['overview'],
          popularity: json['popularity'],
          mediaType: json['media_type']
      );
}