import 'dart:convert';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient()
      : _dio = Dio(BaseOptions(
          connectTimeout: 5000,
          receiveTimeout: 5000,
        ));

  // Newsletter Signup
  Future<Response> submitNewsletterSignup({
    required bool newsletter,
    required String email,
  }) async {
    final endpoint = 'https://neureveal.ai/';
    final data = {
      'form_fields[field_eb37685]': newsletter ? 'on' : null,
      'form_fields[email]': email,
    };

    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception('Newsletter Signup Error: ${e.response?.data ?? e.message}');
    }
  }

  // Event Tracking
  Future<Response> trackEvent({
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
  }) async {
    final endpoint = 'https://events.api.secureserver.net/t/1/tl/event';
    final params = {
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
      'trfd': jsonEncode(trfd),
    };

    try {
      final response = await _dio.get(endpoint, queryParameters: params);
      return response;
    } on DioError catch (e) {
      throw Exception('Event Tracking Error: ${e.response?.data ?? e.message}');
    }
  }

  // Event Bus
  Future<Response> postEventBus({required String clientId}) async {
    final endpoint = 'https://csp.secureserver.net/eventbus/web';
    final data = {'clientid': clientId};

    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception('Event Bus Error: ${e.response?.data ?? e.message}');
    }
  }

  // YouTube Player Data
  Future<Response> fetchYouTubePlayerData({bool? prettyPrint}) async {
    final endpoint = 'https://www.youtube.com/youtubei/v1/player';
    final data = {'prettyPrint': prettyPrint};

    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception('YouTube Player Data Error: ${e.response?.data ?? e.message}');
    }
  }

  // YouTube QoE Metrics
  Future<Response> trackYouTubeQoE({
    required String fmt,
    required String cpn,
    required String el,
    required String ns,
    required String docid,
    required String event,
  }) async {
    final endpoint = 'https://www.youtube.com/api/stats/qoe';
    final data = {
      'fmt': fmt,
      'cpn': cpn,
      'el': el,
      'ns': ns,
      'docid': docid,
      'event': event,
    };

    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception('YouTube QoE Metrics Error: ${e.response?.data ?? e.message}');
    }
  }

  // YouTube Watch Time Metrics
  Future<Response> trackYouTubeWatchTime({
    required String ns,
    required String el,
    required String cpn,
    required String fmt,
    required String state,
    required String volume,
  }) async {
    final endpoint = 'https://www.youtube.com/api/stats/watchtime';
    final params = {
      'ns': ns,
      'el': el,
      'cpn': cpn,
      'fmt': fmt,
      'state': state,
      'volume': volume,
    };

    try {
      final response = await _dio.get(endpoint, queryParameters: params);
      return response;
    } on DioError catch (e) {
      throw Exception('YouTube Watch Time Metrics Error: ${e.response?.data ?? e.message}');
    }
  }

  // YouTube Log Event
  Future<Response> logYouTubeEvent({required String alt}) async {
    final endpoint = 'https://www.youtube.com/youtubei/v1/log_event';
    final data = {'alt': alt};

    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception('YouTube Log Event Error: ${e.response?.data ?? e.message}');
    }
  }

  // Caching Strategy (Example for Event Tracking)
  final Map<String, Response> _cache = {};

  Future<Response> getCachedTrackEvent({
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
  }) async {
    final cacheKey = '$dh-$ua-$clientName-$cv-$vg-$vtg-$dp-$traceId-$cts-$hitId-$ht';
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    final response = await trackEvent(
      dh: dh,
      ua: ua,
      clientName: clientName,
      cv: cv,
      vg: vg,
      vtg: vtg,
      dp: dp,
      traceId: traceId,
      cts: cts,
      hitId: hitId,
      ht: ht,
      trfd: trfd,
    );

    _cache[cacheKey] = response;
    return response;
  }
}
