import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:society_management/constants/enums.dart';
import 'package:society_management/core/app_export.dart';
import 'package:society_management/services/image_service.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/utils/util.dart';
import 'package:society_management/widgets/app_widgets/app_text.dart';
import 'package:society_management/widgets/misc/misc_widget.dart';

enum DocType { image, pdf }

class AppImageSelection extends StatefulWidget {
  const AppImageSelection(
      {super.key,
      required this.placeholder,
      this.title,
      required this.name,
      this.validator,
      this.uploadAllowedTypes = UploadAllowedTypes.values});
  final String placeholder;
  final String? title;
  final String name;
  final String? Function(String?)? validator;
  final List<UploadAllowedTypes> uploadAllowedTypes;

  @override
  State<AppImageSelection> createState() => _AppImageSelectionState();
}

class _AppImageSelectionState extends State<AppImageSelection> {
  RxBool isBusy = false.obs;
  RxString imageSource = "".obs;
  RxString fileName = "".obs;
  Rx<DocType> docType = Rx<DocType>(DocType.image);

  late FormFieldState<dynamic> fieldState;

  void selectImage(ImageSource source) async {
    Navigator.pop(context);
    docType.value = DocType.image;
    var image = await ImageService.selectImage(isBusy, source: source);
    isBusy.value = false;
    imageSource.value = image;
    setFieldState();
  }

  void selectPDF() async {
    Navigator.pop(context);
    docType.value = DocType.pdf;
    isBusy.value = true;
    var response = await ImageService.getDocument();
    isBusy.value = false;
    if (response != null) {
      imageSource.value = response['path'];
      fileName.value = response['fileName'];
      setFieldState();
    }
  }

  setFieldState() {
    fieldState.didChange(imageSource.value);
  }

  onTapped(BuildContext context) async {
    var uploadType = await ImageService.selectUploadType(context, [
      UploadAllowedTypes.camera,
      UploadAllowedTypes.gallery,
      UploadAllowedTypes.pdf
    ]);
    if (uploadType != null) {
      switch (uploadType) {
        case UploadAllowedTypes.camera:
          selectImage(ImageSource.camera);
          break;
        case UploadAllowedTypes.gallery:
          selectImage(ImageSource.gallery);
          break;
        case UploadAllowedTypes.pdf:
          selectPDF();
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        name: widget.name,
        validator: widget.validator,
        builder: (FormFieldState<dynamic> field) {
          fieldState = field;
          var value = field.value;
          if (value != null && value.isNotEmpty) {
            if (value.toString().isPDFFileName && fileName.isEmpty) {
              fileName.value = value;
              docType.value = DocType.pdf;
            } else if (imageSource.isEmpty) {
              imageSource.value = value;
              docType.value = DocType.image;
            }
          }

          return InputDecorator(
              decoration: InputDecoration(
                // labelText: "",
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                errorText: field.errorText,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.title != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: AppText(
                        text: widget.title!,
                        style: AppText.defaultFontStyle
                            .copyWith(color: const Color(0xFF4A4A4A)),
                      ),
                    ),
                  GestureDetector(
                    onTap: () => onTapped(context),
                    child: Container(
                      width: SizeUtils.width,
                      height: 100,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.border),
                          borderRadius: BorderRadius.circular(10)),
                      child: Obx(
                        () => isBusy.isTrue
                            ? const LoadingWidget()
                            : imageSource.isNotEmpty
                                ? docType.value == DocType.image
                                    ? CustomImageView(
                                        height: 90,
                                        imagePath:
                                            Util.getImageUrl(imageSource.value),
                                      )
                                    : Column(
                                        children: [
                                          Image.asset(
                                            "assets/icons/pdf.png",
                                            width: 75,
                                            height: 75,
                                          ),
                                          AppText(
                                            text: fileName.value,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.attachment,
                                        color: Colors.black54,
                                      ),
                                      AppText(
                                        text: widget.placeholder,
                                        padding: const EdgeInsets.only(top: 5),
                                      )
                                    ],
                                  ),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
