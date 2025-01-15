import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:society_management/core/error/dio_custom_error.dart';
import 'package:society_management/services/throttler.dart';

class SnackbarUtil {
  static bool isLoggedOut = false;
  static Throttler throttler = Throttler(milliseconds: 2000);
  static void info({
    required String message,
    bool isInfo = true,
    Function(dynamic)? onTap,
    Duration duration = const Duration(milliseconds: 2500),
    SnackPosition snackPosition = SnackPosition.TOP,
  }) {
    throttler.milliseconds = duration.inMilliseconds + 500;
    throttler.run(() {
      Get.rawSnackbar(
          duration: duration,
          snackPosition: snackPosition,
          onTap: onTap,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: isInfo ? Colors.amber : Colors.green,
          borderRadius: 50,
          messageText: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: 'Metropolis',
            ),
          ));
    });
  }

  static void warning({
    required BuildContext context,
    required String title,
    required String message,
    Function(dynamic)? onTap,
    Duration duration = const Duration(milliseconds: 2500),
    SnackPosition snackPosition = SnackPosition.BOTTOM,
  }) {
    throttler.milliseconds = duration.inMilliseconds + 500;
    throttler.run(() {
      Get.rawSnackbar(
          duration: duration,
          snackPosition: snackPosition,
          onTap: onTap,
          titleText: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
          messageText: Text(
            message,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
          ));
    });
  }

  static void error({
    String? title,
    required String message,
    Function(dynamic)? onTap,
    Duration duration = const Duration(milliseconds: 5000),
    SnackPosition snackPosition = SnackPosition.TOP,
    String? logScreenName = '',
    String? logMethodName = '',
    String? logMessage = '',
  }) {
    throttler.milliseconds = duration.inMilliseconds + 500;
    throttler.run(() {
      log('$logScreenName ----> $logMethodName ----> $logMessage');
      print(Get.currentRoute);
      bool isUnexpectedError = message.contains(
              "type 'String' is not a subtype of type 'Map<String, dynamic>' in type cast") ||
          message.contains("Faildd host lookup");

      if (!isUnexpectedError) {
        Get.rawSnackbar(
          duration: duration,
          snackPosition: snackPosition,
          onTap: onTap,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: Colors.amber,
          borderRadius: 50,
          boxShadows: [
            const BoxShadow(
                color: Colors.black12, spreadRadius: 4, blurRadius: 8)
          ],
          messageText: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: 'Metropolis',
            ),
          ),
        );
      }
    });
  }

  static void showAPIError(Failure failure, route, methodName) {
    var message = (failure as DioCustomError).errorMessage.toString();
    SnackbarUtil.error(
      logMessage: message,
      logScreenName: route,
      logMethodName: methodName,
      message: (failure).errorMessage.toString(),
    );
  }
}
