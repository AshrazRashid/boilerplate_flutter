import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:society_management/core/app_export.dart';
import 'package:society_management/core/error/dio_custom_error.dart';
import 'package:society_management/services/app_preferences.dart';
import '../../../helpers/app_helper.dart';
import '../../../repos/auth_repo.dart';

class SigninController extends GetxController {
  RxBool isBusy = false.obs;
  final formKey = GlobalKey<FormBuilderState>();
  final RxBool remmeberMe = false.obs;
  final _authRepo = Get.find<AuthRepository>();

  onLogin() {
    if (formKey.currentState!.saveAndValidate()) {
      login(formKey.currentState!.value);
    }
  }

  login(data) async {
    isBusy.value = true;
    var result = await _authRepo.login(data);
    isBusy.value = false;
    result.fold((failure) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'Dismiss',
            textColor: Colors.white,
            onPressed: () {
              // Some code to undo the change.
            },
          ),
          content: Text((failure as DioCustomError).errorMessage.toString())));
      // SnackbarUtil.showAPIError(failure, AppRoutes.signUpScreen, 'login'),
    }, (r) {
      AppPreferences.setLogin(r!);
      AppHelper.handleFirebaseToken(null);
      Get.offNamedUntil(

          // AppRoutes.dashboardScreen,
          AppRoutes.signInScreen,
          (route) => false);
    });
  }
}
