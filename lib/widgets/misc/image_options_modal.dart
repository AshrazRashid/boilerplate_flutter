import 'package:flutter/material.dart';

import '../../constants/enums.dart';

class ImageOptionsModal extends StatelessWidget {
  const ImageOptionsModal(
      {super.key, required this.allowedTypes, required this.onSelected});
  final List<UploadAllowedTypes> allowedTypes;
  final Function(UploadAllowedTypes) onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        if (allowedTypes.contains(UploadAllowedTypes.camera))
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Image'),
            onTap: () => onSelected(UploadAllowedTypes.gallery),
          ),
        if (allowedTypes.contains(UploadAllowedTypes.gallery))
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () => onSelected(UploadAllowedTypes.camera),
          ),
        if (allowedTypes.contains(UploadAllowedTypes.pdf))
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: const Text('PDF'),
            onTap: () => onSelected(UploadAllowedTypes.pdf),
          ),
      ],
    );
  }
}
