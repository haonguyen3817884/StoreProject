import 'dart:async';

import 'package:dio/dio.dart';

/// initialize a service with base url
class ApiService {
  static Dio? _dio;
  String baseUrl;
  late Options requestOptions;

  ApiService(
    this.baseUrl, {
    Duration timeout = const Duration(seconds: 60),
  }) {
    requestOptions = _initRequestOptions(timeout: timeout);
    _setupDio();
  }

  Options _initRequestOptions({
    Duration timeout = const Duration(seconds: 60),
  }) {
    return Options(
      receiveDataWhenStatusError: true,
      receiveTimeout: timeout.inMilliseconds,
    );
  }

  void _setupDio() {
    if (_dio != null) return;

    // create dio instance with options above
    _dio = Dio();
  }

  Future<Response<T>> getData<T>({
    required String endPoint,
    Map<String, dynamic>? query,
  }) async {
    try {
      Response<T> response = await _dio!.get<T>(baseUrl + endPoint,
          queryParameters: query, options: requestOptions);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
