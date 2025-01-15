import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:society_management/constants/constant.dart';
import 'package:society_management/core/app_export.dart';
import 'package:society_management/repos/app_repo.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/utils/snackbar_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:society_management/widgets/misc/image_options_modal.dart';
import '../constants/enums.dart';

class ImageService {
  static Future<File?> pickImage() {
    return getImage(ImageSource.gallery);
  }

  static Future<File?> captureImage() {
    return getImage(ImageSource.camera);
  }

  static Future<File?> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: source);
    File? imageFile;

    if (image != null) {
      var length = await image.length();

      // Add 2 MB limit (2 MB = 2 * 1024 * 1024 bytes)
      var sizeLimit = AppConstants.fileSizeLimitInMB * 1024 * 1024;
      if (length > sizeLimit) {
        SnackbarUtil.info(
            message:
                "Can not upload more than ${AppConstants.fileSizeLimitInMB} mb image",
            duration: Duration(seconds: 4));
        return null; // or handle this case as needed
      } else {
        imageFile = await cropImage(File(image.path));
      }
    }
    return imageFile;
  }

  static Future<File?> cropImage(File file) async {
    var croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.primary,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            // CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            // CropAspectRatioPresetCustom(), // IMPORTANT: iOS supports only one custom aspect ratio in preset list
          ],
        ),
        WebUiSettings(
          context: Get.context!,
        ),
      ],
    );
    return croppedImage != null ? File(croppedImage.path) : file;
  }

  static Future<File> _writeByteDataToFile(
      Future<ByteData?> byteDataFuture, String fileName) async {
    try {
      // Wait for the ByteData to be available
      ByteData? byteData = await byteDataFuture;
      if (byteData == null) {
        throw Exception('ByteData is null');
      }

      // Convert ByteData to Uint8List
      Uint8List bytes = byteData.buffer.asUint8List();

      // Get the temporary directory
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      // Create a file in the temporary directory
      File file = File('$tempPath/$fileName');

      // Write the bytes to the file
      await file.writeAsBytes(bytes);

      return file;
    } catch (e) {
      throw Exception('Error writing ByteData to file: $e');
    }
  }

  static Future<dynamic> selectImage(RxBool isBusy,
      {bool shouldUpload = true,
      ImageSource source = ImageSource.gallery}) async {
    var file = await getImage(source);
    isBusy.value = true;
    if (shouldUpload) {
      return file != null ? uploadFile(file) : null;
    }
    return file;
  }

  static Future<String?> uploadFile(File file) async {
    var appRepo = Get.find<AppRepository>();
    var result = await appRepo.uploadFiles([file]);
    return result.fold((failure) {
      SnackbarUtil.showAPIError(failure, AppRoutes.signInScreen, 'uploadImage');
      return null;
    }, (res) => res[0]);
  }

  static Future<File?> getDocumentFile() async {
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    return result != null ? File(result.files[0].path!) : null;
  }

  static Future<Map?> getDocument() async {
    File? file = await getDocumentFile();
    if (file != null) {
      var response = await uploadFile(file);
      return {"path": response, "fileName": file.path.split('/').last};
    }
    return null;
  }

  static Future<UploadAllowedTypes?> selectUploadType(
      BuildContext context, List<UploadAllowedTypes> uploadAllowedTypes) async {
    final result = await showModalBottomSheet<UploadAllowedTypes?>(
        context: context,
        builder: (BuildContext context) {
          return ImageOptionsModal(
              allowedTypes: uploadAllowedTypes,
              onSelected: (value) {
                Navigator.pop(context, value);
              });
        });
    return result;
  }

  static Future<File?> getFile(BuildContext context,
      {List<UploadAllowedTypes> uploadAllowedTypes = const [
        UploadAllowedTypes.camera,
        UploadAllowedTypes.gallery,
        UploadAllowedTypes.pdf
      ]}) async {
    final result =
        await ImageService.selectUploadType(context, uploadAllowedTypes);
    if (result == null) {
      return null;
    }
    File? file;
    switch (result) {
      case UploadAllowedTypes.camera:
        file = await getImage(ImageSource.camera);
        break;
      case UploadAllowedTypes.gallery:
        file = await getImage(ImageSource.gallery);
        break;
      case UploadAllowedTypes.pdf:
        file = await getDocumentFile();
        break;
    }

    return file;
  }
}
