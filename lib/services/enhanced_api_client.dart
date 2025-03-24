import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  final Dio _dio;

  DioClient._internal(this._dio);

  factory DioClient({required String baseUrl}) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add authentication token if needed
          // options.headers['Authorization'] = 'Bearer <token>';
          handler.next(options);
        },
        onError: (DioError error, handler) async {
          if (error.type == DioErrorType.response) {
            // Handle specific HTTP errors
            switch (error.response?.statusCode) {
              case 401:
                // Handle unauthorized
                break;
              case 500:
                // Handle server error
                break;
              default:
                break;
            }
          } else if (error.type == DioErrorType.other &&
              error.error is SocketException) {
            // Handle network issues
            debugPrint('No internet connection');
          }
          handler.next(error);
        },
      ),
    ]);

    return DioClient._internal(dio);
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParams);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.delete(endpoint, data: data);
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  DioError _handleError(DioError error) {
    if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      return DioError(
        requestOptions: error.requestOptions,
        error: 'Connection timeout. Please try again later.',
      );
    }
    if (error.type == DioErrorType.other && error.error is SocketException) {
      return DioError(
        requestOptions: error.requestOptions,
        error: 'No internet connection. Please check your network.',
      );
    }
    return error;
  }
}

class ApiService {
  final DioClient _client;

  ApiService({required DioClient client}) : _client = client;

  Future<Response> trackUserEvent({
    required String dh,
    required String ua,
    required String clientName,
    required String cv,
    required String vg,
    required String vtg,
    required String dp,
    required String traceId,
    required String cts,
    required String hitId,
    required String ht,
    required Map<String, dynamic> trfd,
  }) {
    return _client.get(
      'https://events.api.secureserver.net/t/1/tl/event',
      queryParams: {
        'dh': dh,
        'ua': ua,
        'client_name': clientName,
        'cv': cv,
        'vg': vg,
        'vtg': vtg,
        'dp': dp,
        'trace_id': traceId,
        'cts': cts,
        'hit_id': hitId,
        'ht': ht,
        'trfd': trfd,
      },
    );
  }

  Future<Response> postEventBus({required String clientId}) {
    return _client.post(
      'https://csp.secureserver.net/eventbus/web',
      data: {'clientid': clientId},
    );
  }

  Future<Response> fetchYouTubePlayerData({bool? prettyPrint}) {
    return _client.post(
      'https://www.youtube.com/youtubei/v1/player',
      data: {'prettyPrint': prettyPrint},
    );
  }

  Future<Response> trackYouTubeQoE({
    required String fmt,
    required String cpn,
    required String el,
    required String ns,
    required String docid,
    required String event,
  }) {
    return _client.post(
      'https://www.youtube.com/api/stats/qoe',
      data: {
        'fmt': fmt,
        'cpn': cpn,
        'el': el,
        'ns': ns,
        'docid': docid,
        'event': event,
      },
    );
  }

  Future<Response> trackYouTubeWatchTime({
    required String ns,
    required String el,
    required String cpn,
    required String fmt,
    required String state,
    required String volume,
  }) {
    return _client.get(
      'https://www.youtube.com/api/stats/watchtime',
      queryParams: {
        'ns': ns,
        'el': el,
        'cpn': cpn,
        'fmt': fmt,
        'state': state,
        'volume': volume,
      },
    );
  }

  Future<Response> logYouTubeEvent({required String alt}) {
    return _client.post(
      'https://www.youtube.com/youtubei/v1/log_event',
      data: {'alt': alt},
    );
  }

  Future<Response> submitNewsletterSignup({
    required bool newsletter,
    required String email,
  }) {
    return _client.post(
      'https://neureveal.ai/',
      data: {
        'form_fields[field_eb37685]': newsletter,
        'form_fields[email]': email,
      },
    );
  }
}
