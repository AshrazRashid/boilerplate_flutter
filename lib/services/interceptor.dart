import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:society_management/services/api_service.dart';
import 'package:society_management/services/app_preferences.dart';
import 'package:society_management/utils/snackbar_util.dart';
import 'package:society_management/widgets/misc/drawer/drawer_controller.dart';

import '../core/app_export.dart';

class ElTanvirInterceptors extends dio.Interceptor {
  @override
  Future<void> onRequest(
    dio.RequestOptions options,
    dio.RequestInterceptorHandler handler,
  ) async {
    var token = AppPreferences.token;

    if (token != null && token.isNotEmpty) {
      if (AppPreferences.getLogin() != null &&
          AppPreferences.getLogin()!.getJwtExpiry().isBefore(DateTime.now())) {
        SnackbarUtil.info(
            message: "Session expired! Please login again",
            duration: const Duration(seconds: 5));
        Get.find<DrawerWidgetController>().logout();
        return;
      }
      // else if (!networkInfo.isConnectionAvailable) {
      //   return;
      // }
      else {
        options.headers['Authorization'] = "Bearer $token";
        log("JWT = $token");
      }
    }
    options.validateStatus = (status) {
      // Allow status codes 200 and 307 to pass without throwing an exception
      return status! < 300 || status == 307;
    };
    // options.headers['Accept'] = "application/json";
    if (options.data is! dio.FormData && options.data != null) {
      options.headers['Content-Type'] = "application/json";
    }
    if (kDebugMode && options.data != null && options.data is! dio.FormData) {
      log(jsonEncode(options.data));
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
      dio.Response response, dio.ResponseInterceptorHandler handler) async {
    // Handle 307 Temporary Redirect
    if (response.statusCode == 307) {
      final newUrl = response.headers['location']?.first;
      if (newUrl != null) {
        try {
          // Create a new Dio instance or use the existing one
          final dioInstance = getDio();

          // Make a new request to the URL in the Location header
          final redirectedResponse = await dioInstance.request(
            newUrl,
            options: Options(
              method: response.requestOptions.method,
              headers: response.requestOptions.headers,
            ),
            data: response.requestOptions.data is dio.FormData
                ? clone(response.requestOptions.data)
                : response.requestOptions.data,
          );

          // Forward the redirected response
          return handler.resolve(redirectedResponse);
        } catch (e) {
          // return handler.reject(DioError(
          //   requestOptions: response.requestOptions,
          //   error: e,
          // ));
        }
      }
    }
    if (response.statusCode == 401) {
      debugPrint('Got Response: 401 Unauthorized');
    }

    return super.onResponse(response, handler);
  }

  @override
  void onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    debugPrint('Request Error: ${err.message}');
    return super.onError(err, handler);
  }

  dio.FormData clone(dio.FormData data) {
    final clone = dio.FormData();
    clone.fields.addAll(data.fields);
    for (final file in data.files) {
      clone.files.add(MapEntry(file.key, file.value.clone()));
    }
    return clone;
  }
}
