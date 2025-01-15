import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  // Constructor to initialize Dio with optional base URL
  ApiService({String? baseUrl}) {
    if (baseUrl != null) {
      _dio.options.baseUrl = baseUrl;
    }
  }

  // GET request
  Future<Response> getRequest(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      Response response =
          await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  Future<Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Set headers
  void setHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }
}
