import 'package:flutter/material.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/theme/custom_text_style.dart';
import 'package:society_management/theme/fonts.dart';
import 'package:society_management/utils/util.dart';
import 'package:society_management/widgets/app_widgets/app_text.dart';

class DevelopedByWidget extends StatelessWidget {
  const DevelopedByWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: AppColors.border.withOpacity(0.5),
        ),
        AppText(text: "Developed By"),
        GestureDetector(
          onTap: () {
            Util.launchWhatsApp("+923343355003");
          },
          child: AppText(
            text: "Nascent Innovations",
            padding: EdgeInsets.only(bottom: 10),
            style: CustomTextStyles.titleMedium16
                .copyWith(color: AppColors.primary, fontFamily: Fonts.semiBold),
          ),
        )
      ],
    );
  }
}
