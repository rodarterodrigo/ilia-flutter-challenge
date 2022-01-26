import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdb_trending/app/core/packages/dio_client.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:imdb_trending/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:imdb_trending/app/modules/trending/movies/external/datasources/get_trending_movies_datasource_implementation.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/exceptions/get_trending_movies_list_datasource_exception.dart';
import 'package:imdb_trending/app/modules/trending/movies/infrastructure/models/movie_list_page_model.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/get_trending_movies_datasource_not_found_response.dart';
import '../mocks/get_trending_movies_datasource_success_response.dart';
import '../mocks/get_trending_movies_datasource_unauthorized_response.dart';

class DioClientMock extends Mock implements DioClient{}
class OptionsFake extends Fake implements Options{}

final dio = DioClientMock();
final datasource = GetTrendingMoviesDatasourceImplementation(dio);

void main(){
  setUp((){
    registerFallbackValue(OptionsFake());
  });

  test('Must complete the request', (){
    when(() => dio.get(any(), any())).thenAnswer((realInvocation) async =>
        Response(data: getTrendingMoviesDatasourceSuccessResponse, statusCode: 200, requestOptions: RequestOptions(path: '')));
    final result = datasource('timeWindow', 1);
    expect(result, completes);
  });

  test('Must return an MovieListPageModel', () async{
    when(() => dio.get(any(), any())).thenAnswer((realInvocation) async =>
        Response(data: getTrendingMoviesDatasourceSuccessResponse, statusCode: 200, requestOptions: RequestOptions(path: '')));
    final result = await datasource('timeWindow', 1);
    expect(result, isA<MovieListPageModel>());
  });

  test('Must throw an GetTrendingMoviesListDatasourceException', () async{
    when(() => dio.get(any(), any())).thenAnswer((realInvocation) async =>
        Response(data: getTrendingMoviesDatasourceSuccessResponse, statusCode: 500, requestOptions: RequestOptions(path: '')));
    final result = datasource('timeWindow', 1);
    expect(result, throwsA(isA<GetTrendingMoviesListDatasourceException>()));
  });

  test('Must throw an NotFoundDatasourceException', () async{
    when(() => dio.get(any(), any())).thenAnswer((realInvocation) async =>
        Response(data: getTrendingMoviesDatasourceNotFoundResponse, statusCode: 404, requestOptions: RequestOptions(path: '')));
    final result = datasource('timeWindow', 1);
    expect(result, throwsA(isA<NotFoundDatasourceException>()));
  });

  test('Must throw an UnauthorizedDatasourceException', () async{
    when(() => dio.get(any(), any())).thenAnswer((realInvocation) async =>
        Response(data: getTrendingMoviesDatasourceUnauthorizedResponse, statusCode: 401, requestOptions: RequestOptions(path: '')));
    final result = datasource('timeWindow', 1);
    expect(result, throwsA(isA<UnauthorizedDatasourceException>()));
  });

  test('Must throw an GetTrendingMoviesListDatasourceException', () async{
    when(() => dio.get(any(), any())).thenThrow(GetTrendingMoviesListDatasourceException('GetTrendingMoviesListDatasourceException'));
    final result = datasource('timeWindow', 1);
    expect(result, throwsA(isA<GetTrendingMoviesListDatasourceException>()));
  });

  test('Must throw an UnauthorizedDatasourceException', () async{
    when(() => dio.get(any(), any())).thenThrow(UnauthorizedDatasourceException('UnauthorizedDatasourceException'));
    final result = datasource('timeWindow', 1);
    expect(result, throwsA(isA<UnauthorizedDatasourceException>()));
  });

  test('Must throw an NotFoundDatasourceException', () async{
    when(() => dio.get(any(), any())).thenThrow(NotFoundDatasourceException('NotFoundDatasourceException'));
    final result = datasource('timeWindow', 1);
    expect(result, throwsA(isA<NotFoundDatasourceException>()));
  });
}