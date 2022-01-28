import 'package:tmdb_trending/app/core/config/config.dart';
import 'package:tmdb_trending/app/core/packages/http_client.dart';
import 'package:tmdb_trending/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:tmdb_trending/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:tmdb_trending/app/core/shared/infrastructure/models/movie_list_model.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/domain/entities/search_movie_parameter.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/external/settings/search_movie_settings.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/infrastructure/datasources/search_movie_datasource.dart';
import 'package:tmdb_trending/app/modules/trending/movies/sub-modules/movie_search/infrastructure/exceptions/search_movie_datasource_exception.dart';

class SearchMovieDatasourceImplementation implements SearchMovieDatasource {
  final RequestClient requestClient;

  const SearchMovieDatasourceImplementation(this.requestClient);

  @override
  Future<MovieListModel> call(SearchMovieParameter parameter) async {
    final response = await requestClient.get("${ServerConfiguration.serverHost}"
        "${SearchMovieSettings.output}"
        "?query=${parameter.searchValue}"
        "&api_key=${ServerConfiguration.apiKey}"
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
        throw const SearchMovieDatasourceException('Houve um erro interno');
    }
  }
}
