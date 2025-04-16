import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  late Dio _request;

  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: "",
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 30),
        headers: {},
        contentType: "application/json",
        responseType: ResponseType.json);
    _request = Dio(options);
    if (kDebugMode) {
      _request.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false,
          request: true,
          requestBody: true)
      );
    }
  }

  Future<dynamic> get(
      String uri, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await _request.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await _request.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }
}