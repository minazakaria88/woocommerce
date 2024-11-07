import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import 'end_points.dart';

class ApiHelper {
  final Dio dio;

  ApiHelper({required this.dio}) {
    //get data first from the cache
    final options = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.forceCache,
      maxStale: const Duration(minutes: 10)
    );

    dio.options.baseUrl = EndPoints.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveDataWhenStatusError = true;
    //dio.interceptors.add(DioCacheInterceptor(options: options));
    dio.options.headers['authorization'] =
        'Basic ${base64Encode(utf8.encode('${EndPoints.consumerKey}:${EndPoints.secretKey}'))}';
  }

  Future<Response> getData({
    required final String url,
    final Map<String, dynamic>? query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  Future<Response> postData({
    required final String url,
    final Map<String, dynamic>? query,
    final Map<String, dynamic>? data,
  }) async {
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }


  Future<Response> putData({
    required final String url,
    final Map<String, dynamic>? query,
    final Map<String, dynamic>? data,
  }) async {
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
