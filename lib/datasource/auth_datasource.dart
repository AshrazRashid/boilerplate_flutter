import 'package:dio/dio.dart';
import 'package:society_management/core/error/dio_custom_error.dart';
import 'package:society_management/models/login.dart';
import '../constants/enums.dart';
import '../services/api_service.dart';
import '../utils/api_url_utils.dart';
import 'package:society_management/models/result.dart';

abstract class AuthDataSource {
  Future<String> createUser({required Map<String, dynamic> data});
  Future<Login?> login(Map<String, dynamic> data);
  Future<Result> forgotPassword(cnic);
}

class AuthDataSourceImpl extends AuthDataSource {
  final Dio dio = getDio();

  @override
  Future<String> createUser({required Map<String, dynamic> data}) async {
    try {
      var res = await dio.post(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.register),
        data: data,
      );
      return res.data['status'] == 1
          ? res.data['message']
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<Login?> login(Map<String, dynamic> data) async {
    try {
      var res = await dio.post(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.signin),
        data: data,
        options: Options(validateStatus: (status) {
          // Allow status codes 200 and 307 to pass without throwing an exception
          return status! < 300 || status == 307;
        }),
      );
      if (res.statusCode == 307) {
        final newUrl = res.headers['location']?.first;
        if (newUrl != null) {
          res = await dio.post(
            newUrl,
            data: data,
          );
        }
      }

      return res.data['status'] == 1 && res.data['data'] != null
          ? Login.fromJson((res.data['data'] as List<dynamic>)[0])
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }

  @override
  Future<Result> forgotPassword(cnic) async {
    try {
      var res = await dio.post(
        ApiUrlUtils.getApiUrl(UrlEndPointEnum.forgotPassword, id: cnic),
      );
      return res.data['status'] == 1
          ? Result.fromJson(res.data as Map<String, dynamic>)
          : throw DioCustomError(errorMessage: res.data['message']);
    } catch (e) {
      throw DioCustomError.getError(e);
    }
  }
}
