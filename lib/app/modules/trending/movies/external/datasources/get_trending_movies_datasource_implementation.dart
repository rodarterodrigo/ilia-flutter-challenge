import 'package:imdb_trending/app/core/config/config.dart';
import 'package:imdb_trending/app/core/packages/http_client.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:imdb_trending/app/modules/trending/movies/domain/entities/trending_movies_request_parameter.dart';
import 'package:imdb_trending/app/modules/trending/movies/external/settings/get_trending_movies_settings.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/datasources/get_trending_movies_datasource.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/exceptions/get_trending_movies_list_datasource_exception.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/models/movie_list_model.dart';

class GetTrendingMoviesDatasourceImplementation
    implements GetTrendingMoviesDatasource {
  final RequestClient requestClient;

  const GetTrendingMoviesDatasourceImplementation(this.requestClient);

  @override
  Future<MovieListModel> call(TrendingMoviesRequestParameter parameter) async {
    final response = await requestClient.get("${ServerConfiguration.serverHost}"
        "${GetTrendingMovieSettings.output}"
        "${parameter.timeWindow}"
        "?api_key=${ServerConfiguration.apiKey}"
        "&page=${parameter.page}"
        "&language=${parameter.language}"
        "&include_image_language=${parameter.locationLanguage}");

    switch (response.statusCode) {
      case 200:
        return MovieListModel.fromJson(response.data);
      case 401:
        throw UnauthorizedDatasourceException(response.data['status_message']);
      case 404:
        throw NotFoundDatasourceException(response.data['status_message']);
      default:
        throw const GetTrendingMoviesListDatasourceException(
            'Houve um erro interno');
    }
  }
}
