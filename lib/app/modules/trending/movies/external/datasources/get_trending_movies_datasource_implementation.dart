import 'package:dio/dio.dart';
import 'package:imdb_trending/app/core/config/config.dart';
import 'package:imdb_trending/app/core/packages/dio_client.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:imdb_trending/app/modules/trending/movies/external/settings/get_trending_movies_settings.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/datasources/get_trending_movies_datasource.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/exceptions/get_trending_movies_list_datasource_exception.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/models/movie_list_page_model.dart';

class GetTrendingMoviesDatasourceImplementation implements GetTrendingMoviesDatasource{
  final DioClient dio;

  GetTrendingMoviesDatasourceImplementation(this.dio);

  @override
  Future<MovieListPageModel> call(String timeWindow, int page) async{

    final response = await dio.get("${ServerConfiguration().serverHost}"
        "${GetTrendingMovieSettings.output}?api_key=${ServerConfiguration().apiKey}"
        "?page=$page",
      Options(validateStatus: (status) => true)
    );

    switch(response.statusCode){
      case 200:
        return MovieListPageModel.fromJson(response.data);
      case 401:
        throw UnauthorizedDatasourceException(response.data['status_message']);
      case 404:
        throw NotFoundDatasourceException(response.data['status_message']);
      default:
        throw GetTrendingMoviesListDatasourceException('Houve um erro interno');
    }
  }
}