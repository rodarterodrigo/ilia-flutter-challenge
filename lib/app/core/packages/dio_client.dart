import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class DioClient{
  Future<Response> get(String url, Options options);
}

class DioClientImplementation implements DioClient{
  final Dio dio;

  DioClientImplementation(this.dio);

  @override
  Future<Response> get(String url, Options options) async{
    try{
      final response = await dio.get(url, options: options);
      return Response(data: response.data, statusCode: response.statusCode, requestOptions: RequestOptions(path: ''));
    }
    on DioError {
      return Response(data: '', statusCode: 500, requestOptions: RequestOptions(path: ''));
    }
  }
}