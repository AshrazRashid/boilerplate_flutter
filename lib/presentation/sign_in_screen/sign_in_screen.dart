import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:society_management/helpers/cnic_input_formatter.dart';
import 'package:society_management/presentation/sign_in_screen/controller/signin_controller.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/widgets/app_widgets/app_button.dart';
import 'package:society_management/widgets/app_widgets/app_form_field.dart';
import 'package:society_management/widgets/app_widgets/app_text.dart';
import 'package:society_management/widgets/misc/misc_widget.dart';
import '../../../core/app_export.dart';

class SigninScreen extends GetView<SigninController> {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Obx(() => SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 18.0,
                  left: Get.width * 0.05,
                  right: Get.width * 0.05,
                ),
                child: FormBuilder(
                  key: controller.formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            ImageConstant.logo,
                            width: 250,
                          ),
                        ),
                        AppSpacerH(20.v),
                        AppText(
                          text: "lbl_sign_in".tr,
                          style: theme.textTheme.headlineSmall,
                        ),
                        AppSpacerH(10.v),
                        AppFormField(
                          placeholder: "42201-1234567-1",
                          name: "cnic",
                          icon: "cnic",
                          maxLength: 15,
                          formatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            CNICInputFormatter(),
                          ],
                          inputType: TextInputType.number,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(15,
                                errorText: "CNIC should be 13 characters long"),
                            FormBuilderValidators.maxLength(15,
                                errorText: "CNIC should be 13 characters long"),
                          ]),
                        ),
                        AppSpacerH(15.v),
                        AppFormField(
                          placeholder: "Password",
                          name: "password",
                          icon: "lock",
                          obsecureText: true,
                          prefixIconPadding: 10,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                        ),
                        AppSpacerH(10.v),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: Switch(
                                    value: controller.remmeberMe.isTrue,
                                    activeColor: AppColors.primary,
                                    activeTrackColor: AppColors.primary,
                                    inactiveThumbColor: AppColors.primary,
                                    thumbColor:
                                        WidgetStateProperty.resolveWith<Color>(
                                            (Set<WidgetState> states) {
                                      return !states
                                              .contains(WidgetState.selected)
                                          ? AppColors.primary
                                          : Colors.white;
                                    }),
                                    onChanged: (val) {
                                      controller.remmeberMe.value = val;
                                    },
                                  ),
                                ),
                                const AppSpacerW(5),
                                Text(
                                  "lbl_remember_me".tr,
                                  style: CustomTextStyles
                                      .bodyMediumOnPrimaryContainer_1,
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.signInScreen),
                              child: AppText(
                                text: "msg_forgot_password".tr,
                                style: CustomTextStyles
                                    .bodyMediumOnPrimaryContainer_1,
                              ),
                            )
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 10.v, top: 15),
                            child: Obx(
                              () => AppButton(
                                isLoading: controller.isBusy.isTrue,
                                onPressed: controller.onLogin,
                                text: 'SIGN IN',
                              ),
                            )),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "msg_don_t_have_an_account2".tr,
                                  style: CustomTextStyles
                                      .bodyMediumOnPrimaryContainer15,
                                ),
                                TextSpan(
                                  text: "lbl_sign_up".tr,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        Get.toNamed(AppRoutes.signInScreen),
                                  style: CustomTextStyles.bodyMediumGray900,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const AppSpacerH(15),
                      ]),
                ),
              ),
            ),
          )),
    ));
  }
}
