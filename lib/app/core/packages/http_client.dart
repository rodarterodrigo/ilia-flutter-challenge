import 'package:dio/dio.dart';
import 'package:imdb_trending/app/core/packages/http_response.dart';

abstract class RequestClient {
  Future<HttpResponse> get(String url);
}

class RequestClientImplementation implements RequestClient {
  final Dio dio;
  final Options _options = Options(
    validateStatus: (status) => true,
  );

  RequestClientImplementation(this.dio);

  @override
  Future<HttpResponse> get(String url) async {
    try {
      final response = await dio.get(url, options: _options);
      return HttpResponse(
          data: response.data, statusCode: response.statusCode!);
    } catch (e) {
      return const HttpResponse(data: '', statusCode: 500);
    }
  }
}
