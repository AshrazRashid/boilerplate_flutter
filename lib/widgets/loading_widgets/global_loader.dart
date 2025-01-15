import 'package:flutter/material.dart';
import 'package:society_management/core/app_export.dart';
import 'package:society_management/widgets/misc/misc_widget.dart';

class GlobalLoader extends StatelessWidget {
  const GlobalLoader({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          color: Colors.black.withOpacity(0.1),
          child: const LoadingWidget(
            isExpanded: false,
          ),
        ),
        child
      ],
    );
  }
}
