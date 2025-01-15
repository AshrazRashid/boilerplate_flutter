import 'package:flutter/material.dart';
import 'package:society_management/theme/app_colors.dart';

class AppSpacerH extends StatelessWidget {
  const AppSpacerH(
    this.height, {
    super.key,
  });
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class AppSpacerW extends StatelessWidget {
  const AppSpacerW(
    this.width, {
    super.key,
  });
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        //TODO: Add Style style: AppTextDecor.textMedium14Red,
      ),
    );
  }
}

class MessageTextWidget extends StatelessWidget {
  const MessageTextWidget({super.key, required this.msg});
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        msg,
        //TODO: Add Style style: AppTextDecor.textMedium14Black,
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.isExpanded = false, this.color});
  final Color? color;
  final bool isExpanded;

  _buildChild() => Center(
          child: CircularProgressIndicator(
        color: color ?? AppColors.primary,
      ));

  @override
  Widget build(BuildContext context) {
    return !isExpanded ? _buildChild() : Expanded(child: _buildChild());
  }
}
