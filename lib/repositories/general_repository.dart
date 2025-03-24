import 'dart:convert';
import 'package:http/http.dart' as http;

// Abstract Repository Interface
abstract class AnalyticsRepository {
  Future<Map<String, dynamic>> trackUserEvent(Map<String, dynamic> params);
  Future<Map<String, dynamic>> sendEventBusMessage(Map<String, dynamic> params);
  Future<Map<String, dynamic>> fetchYouTubePlayerData(Map<String, dynamic> params);
  Future<Map<String, dynamic>> trackYouTubeQoEMetrics(Map<String, dynamic> params);
  Future<Map<String, dynamic>> trackYouTubeWatchTime(Map<String, dynamic> params);
  Future<Map<String, dynamic>> logYouTubeEvent(Map<String, dynamic> params);
}

// Concrete Implementation
class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final http.Client client;

  AnalyticsRepositoryImpl(this.client);

  @override
  Future<Map<String, dynamic>> trackUserEvent(Map<String, dynamic> params) async {
    final uri = Uri.parse('https://events.api.secureserver.net/t/1/tl/event');
    return _handleGetRequest(uri, params);
  }

  @override
  Future<Map<String, dynamic>> sendEventBusMessage(Map<String, dynamic> params) async {
    final uri = Uri.parse('https://csp.secureserver.net/eventbus/web');
    return _handlePostRequest(uri, params);
  }

  @override
  Future<Map<String, dynamic>> fetchYouTubePlayerData(Map<String, dynamic> params) async {
    final uri = Uri.parse('https://www.youtube.com/youtubei/v1/player');
    return _handlePostRequest(uri, params);
  }

  @override
  Future<Map<String, dynamic>> trackYouTubeQoEMetrics(Map<String, dynamic> params) async {
    final uri = Uri.parse('https://www.youtube.com/api/stats/qoe');
    return _handlePostRequest(uri, params);
  }

  @override
  Future<Map<String, dynamic>> trackYouTubeWatchTime(Map<String, dynamic> params) async {
    final uri = Uri.parse('https://www.youtube.com/api/stats/watchtime');
    return _handleGetRequest(uri, params);
  }

  @override
  Future<Map<String, dynamic>> logYouTubeEvent(Map<String, dynamic> params) async {
    final uri = Uri.parse('https://www.youtube.com/youtubei/v1/log_event');
    return _handlePostRequest(uri, params);
  }

  Future<Map<String, dynamic>> _handleGetRequest(Uri uri, Map<String, dynamic> params) async {
    try {
      final response = await client.get(uri.replace(queryParameters: params.map((key, value) => MapEntry(key, value.toString()))));
      return _processResponse(response);
    } catch (e) {
      throw _mapErrorToDomainException(e);
    }
  }

  Future<Map<String, dynamic>> _handlePostRequest(Uri uri, Map<String, dynamic> params) async {
    try {
      final response = await client.post(uri, body: jsonEncode(params), headers: {'Content-Type': 'application/json'});
      return _processResponse(response);
    } catch (e) {
      throw _mapErrorToDomainException(e);
    }
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw ApiException(response.statusCode, response.body);
    }
  }

  Exception _mapErrorToDomainException(Exception e) {
    if (e is http.ClientException) {
      return NetworkException(e.message);
    } else if (e is ApiException) {
      return ApiException(e.statusCode, e.message);
    } else {
      return UnknownException(e.toString());
    }
  }
}

// Caching Strategy (Optional Example)
class CacheManager {
  final Map<String, Map<String, dynamic>> _cache = {};

  void saveToCache(String key, Map<String, dynamic> data) {
    _cache[key] = data;
  }

  Map<String, dynamic>? getFromCache(String key) {
    return _cache[key];
  }

  void clearCache(String key) {
    _cache.remove(key);
  }
}

// Domain Exceptions
class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException(this.statusCode, this.message);

  @override
  String toString() => 'ApiException: $statusCode - $message';
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);

  @override
  String toString() => 'UnknownException: $message';
}
