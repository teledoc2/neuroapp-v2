// Abstract Repository Interface
abstract class FormRepository {
  Future<void> submitNewsletterSignup(Map<String, dynamic> formData);
}

// Domain Exceptions
class FormValidationException implements Exception {
  final String message;
  FormValidationException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class UnknownException implements Exception {
  final String message;
  UnknownException(this.message);
}

// Concrete Implementation
import 'dart:convert';
import 'package:http/http.dart' as http;

class FormRepositoryImpl implements FormRepository {
  final http.Client apiClient;

  FormRepositoryImpl(this.apiClient);

  static const String _submissionEndpoint = "https://neureveal.ai/";

  @override
  Future<void> submitNewsletterSignup(Map<String, dynamic> formData) async {
    try {
      // Validate form data
      _validateFormData(formData);

      // Submit form data
      final response = await apiClient.post(
        Uri.parse(_submissionEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(formData),
      );

      if (response.statusCode != 200) {
        throw NetworkException('Failed to submit form: ${response.body}');
      }
    } catch (e) {
      throw _mapException(e);
    }
  }

  void _validateFormData(Map<String, dynamic> formData) {
    if (!formData.containsKey('form_fields[field_eb37685]') ||
        formData['form_fields[field_eb37685]'] != true) {
      throw FormValidationException('Newsletter checkbox is required.');
    }

    if (!formData.containsKey('form_fields[email]') ||
        formData['form_fields[email]'].toString().isEmpty) {
      throw FormValidationException('Email is required.');
    }

    final email = formData['form_fields[email]'];
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(email)) {
      throw FormValidationException('Invalid email format.');
    }
  }

  Exception _mapException(Exception e) {
    if (e is http.ClientException) {
      return NetworkException('Network error occurred.');
    } else if (e is FormValidationException) {
      return e;
    } else {
      return UnknownException('An unknown error occurred.');
    }
  }
}

// Usage Example
void main() async {
  final repository = FormRepositoryImpl(http.Client());

  final formData = {
    'form_fields[field_eb37685]': true,
    'form_fields[email]': 'test@example.com',
  };

  try {
    await repository.submitNewsletterSignup(formData);
    print('Form submitted successfully.');
  } catch (e) {
    if (e is FormValidationException) {
      print('Validation Error: ${e.message}');
    } else if (e is NetworkException) {
      print('Network Error: ${e.message}');
    } else if (e is UnknownException) {
      print('Unknown Error: ${e.message}');
    }
  }
}
