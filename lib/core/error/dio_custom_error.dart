import 'package:dio/dio.dart';

abstract class Failure {}

class DioCustomError extends Failure {
  final String errorMessage;

  DioCustomError({required this.errorMessage});

  static getError(e, {bool serverException = false}) {
    if (serverException) return e.data['message'];
    if (e is DioCustomError) {
      return e.errorMessage;
    }
    var error = (e as DioException);
    var response = error.response != null
        ? (error.response?.data as Map<String, dynamic>)
        : null;
    return response != null && response.containsKey('message')
        ? response['message']
        : error.message;
  }
}
