import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:quickalert/quickalert.dart';
import 'package:society_management/core/app_export.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/widgets/app_widgets/app_form_field.dart';
import 'package:society_management/widgets/app_widgets/app_text.dart';

class AlertsUtil {
  static BuildContext context = Get.context!;
  static showConfirmation(
    message, {
    String title = "Are you sure?",
    String confirmText = "Yes",
    String cancelText = "No",
    confirmBtnColor = AppColors.primary,
    Function(bool)? onAction,
  }) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: title,
      text: message,
      confirmBtnText: confirmText,
      cancelBtnText: cancelText,
      confirmBtnColor: confirmBtnColor,
      onConfirmBtnTap: () {
        Navigator.pop(context);
        if (onAction != null) onAction(true);
      },
      onCancelBtnTap: () {
        Navigator.pop(context);
        if (onAction != null) onAction(false);
      },
    );
  }

  static showInfo(message, {title, confirmText}) {
    var ctx = Get.context!;
    return QuickAlert.show(
        context: ctx,
        title: title,
        type: QuickAlertType.info,
        text: message,
        confirmBtnColor: AppColors.primary,
        confirmBtnText: confirmText);
  }

  static getInput(TextEditingController inputConroller) {
    QuickAlert.show(
      context: Get.context!,
      type: QuickAlertType.custom,
      barrierDismissible: true,
      confirmBtnText: 'Cance',

      title: 'Custom',
      text: 'Custom Widget Alert',

      // customAsset: 'assets/custom.gif',
      widget: TextFormField(
        controller: inputConroller,
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          hintText: 'Enter Phone Number',
          prefixIcon: Icon(
            Icons.phone_outlined,
          ),
        ),
        // textInputAction: TextInputAction.next,
        //   keyboardType: TextInputType.phone,
        //   onChanged: (value) => message = value,
      ),
      onConfirmBtnTap: () async {
        if (inputConroller.text.length < 5) {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'Please input something',
          );
          return;
        }
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 1000));
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: "Phone number '${inputConroller.text}' has been saved!.",
        );
      },
    );
  }

  static void showInputDialog(Function(String) callback,
      {required String title,
      required String placeholder,
      String message = "",
      String errorText = "Field is required",
      String confirmButtonText = "Submit"}) {
    final formKey = GlobalKey<FormBuilderState>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            height: 80,
            child: FormBuilder(
                key: formKey,
                child: AppFormField(
                    name: "reason",
                    placeholder: placeholder,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]))),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const AppText(
                text: "Cancel",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.saveAndValidate()) {
                  String reason = formKey.currentState!.value['reason'];
                  print('Cancellation reason: $reason');
                  callback(reason);
                  Navigator.of(context).pop(); // Close the dialog after input
                }
              },
              child: AppText(
                text: confirmButtonText,
                style:
                    AppText.defaultFontStyle.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  static handleUnAuthenticatedUse() {
    showConfirmation("You must be logged in to access, Do you want to login?",
        title: "Login Confirmation", confirmText: "Yes", onAction: (isConfirm) {
      if (isConfirm) {
        Get.offNamedUntil(AppRoutes.signInScreen, (route) => false);
      }
    });
  }
}
