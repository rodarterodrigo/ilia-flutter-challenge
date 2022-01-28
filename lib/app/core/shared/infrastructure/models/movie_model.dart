import 'package:tmdb_trending/app/core/shared/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
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
  }) : super(
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

  factory MovieModel.fronJson(Map<String, dynamic> json) => MovieModel(
      releaseDate: json['release_date'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      id: json['id'] ?? -1,
      posterPath: json['poster_path'] ?? '',
      haveVideo: json['video'] ?? false,
      voteAverage: double.parse((json['vote_average']).toString()),
      title: json['title'] ?? '',
      voteCount: json['vote_count'] ?? -1,
      genreIds: (json['genre_ids'] as List).map((e) => e as int).toList(),
      originalTitle: json['original_title'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      isAdult: json['adult'] ?? false,
      overview: json['overview'] ?? '',
      popularity: json['popularity'] ?? -1,
      mediaType: json['media_type'] ?? '');
}
