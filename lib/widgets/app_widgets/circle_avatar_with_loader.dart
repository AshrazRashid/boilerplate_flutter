import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:society_management/theme/app_colors.dart';

class CircleAvatarWithLoader extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final String? placeholderImageUrl;
  final File? fileImage;
  final Color color;
  final bool isLoading;

  const CircleAvatarWithLoader(
      {super.key,
      this.imageUrl,
      this.radius = 30.0,
      this.placeholderImageUrl = "assets/images/avatar.png",
      this.color = Colors.white,
      this.fileImage,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: ClipOval(
        child: fileImage != null
            ? Image.file(fileImage!)
            : imageUrl != null
                ? isLoading
                    ? _buildPlaceholderImage()
                    : CachedNetworkImage(
                        imageUrl: imageUrl!,
                        placeholder: (context, url) => _buildPlaceholderImage(),
                        errorWidget: (context, url, error) =>
                            _buildErrorImage(),
                        fadeInDuration: const Duration(milliseconds: 300),
                        fit: BoxFit.cover,
                        width: radius * 2,
                        height: radius * 2,
                      )
                : placeholderImageUrl != null && placeholderImageUrl!.isNotEmpty
                    ? _buildErrorImage()
                    : Container(
                        width: radius * 2,
                        height: radius * 2,
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(radius)),
                      ),
      ),
    );
  }

  Widget _buildErrorImage() =>
      placeholderImageUrl != null && placeholderImageUrl!.isNotEmpty
          ? Image.asset(
              placeholderImageUrl!,
              width: radius * 2,
              height: radius * 2,
              fit: BoxFit.cover,
              color: AppColors.primary.withOpacity(0.6),
            )
          : const SizedBox();

  Widget _buildPlaceholderImage() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    ); // Or any other loader widget
  }
}
