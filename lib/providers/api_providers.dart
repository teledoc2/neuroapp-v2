import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Newsletter Signup Provider
class NewsletterProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSubmitted = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSubmitted => _isSubmitted;

  Future<void> submitNewsletterSignup(String email, bool newsletter) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = Uri.parse('https://neureveal.ai/');
    final body = {
      'form_fields[email]': email,
      'form_fields[field_eb37685]': newsletter ? 'on' : 'off',
    };

    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        _isSubmitted = true;
      } else {
        _errorMessage = 'Failed to submit form. Please try again.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

// Event Tracking Provider
class EventTrackingProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _response;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get response => _response;

  Future<void> trackEvent(Map<String, String> parameters) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = Uri.parse('https://events.api.secureserver.net/t/1/tl/event');

    try {
      final response = await http.get(url.replace(queryParameters: parameters));
      if (response.statusCode == 200) {
        _response = json.decode(response.body);
      } else {
        _errorMessage = 'Failed to track event. Please try again.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

// Event Bus Provider
class EventBusProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _response;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get response => _response;

  Future<void> sendEvent(String clientId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = Uri.parse('https://csp.secureserver.net/eventbus/web');
    final body = {'clientid': clientId};

    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        _response = json.decode(response.body);
      } else {
        _errorMessage = 'Failed to send event. Please try again.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

// YouTube API Provider
class YouTubeProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _response;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get response => _response;

  Future<void> fetchPlayerData({bool prettyPrint = false}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = Uri.parse('https://www.youtube.com/youtubei/v1/player');
    final body = {'prettyPrint': prettyPrint.toString()};

    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        _response = json.decode(response.body);
      } else {
        _errorMessage = 'Failed to fetch player data. Please try again.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logEvent(String alt) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = Uri.parse('https://www.youtube.com/youtubei/v1/log_event');
    final body = {'alt': alt};

    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        _response = json.decode(response.body);
      } else {
        _errorMessage = 'Failed to log event. Please try again.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

// Watch Time Provider
class WatchTimeProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _response;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get response => _response;

  Future<void> trackWatchTime(Map<String, String> parameters) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = Uri.parse('https://www.youtube.com/api/stats/watchtime');

    try {
      final response = await http.get(url.replace(queryParameters: parameters));
      if (response.statusCode == 200) {
        _response = json.decode(response.body);
      } else {
        _errorMessage = 'Failed to track watch time. Please try again.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
