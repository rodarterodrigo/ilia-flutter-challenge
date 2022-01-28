import 'package:tmdb_trending/app/core/config/config.dart';
import 'package:tmdb_trending/app/core/packages/http_client.dart';
import 'package:tmdb_trending/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:tmdb_trending/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/datasources/get_movie_trailer_results_datasource.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/exceptions/get_movie_trailer_datasource_exception.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_trailer/infrastructure/models/movie_trailer_model.dart';

class GetMovieTrailerResultsDatasourceImplementation
    implements GetMovieTrailerResultsDatasource {
  final RequestClient requestClient;

  const GetMovieTrailerResultsDatasourceImplementation(this.requestClient);

  @override
  Future<MovieTrailerModel> call(int movieId) async {
    final response = await requestClient.get("${ServerConfiguration.serverHost}"
        "movie/"
        "$movieId"
        "/videos"
        "?api_key=${ServerConfiguration.apiKey}");

    switch (response.statusCode) {
      case 200:
        return MovieTrailerModel.fromJson(response.data);
      case 401:
        throw UnauthorizedDatasourceException(response.data['status_message']);
      case 404:
        throw NotFoundDatasourceException(response.data['status_message']);
      default:
        throw const GetMovieTrailerDatasourceException('Houve um erro interno');
    }
  }
}
