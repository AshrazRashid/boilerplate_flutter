import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final double length; // This replaces height to be more generic
  final Color color;
  final double gap;
  final double dashedLength; // This replaces dashedHeight to be more generic
  final double thickness;
  final Axis direction;

  const DottedLine({
    super.key,
    required this.length,
    required this.color,
    this.thickness = 1,
    this.gap = 2,
    this.dashedLength = 3,
    this.direction = Axis.vertical, // Default to vertical
  });

  @override
  Widget build(BuildContext context) {
    return direction == Axis.vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              length ~/ 2,
              (index) => Container(
                width: thickness,
                margin: EdgeInsets.only(top: gap),
                height: dashedLength,
                color: color,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              length ~/ 2,
              (index) => Container(
                height: thickness,
                margin: EdgeInsets.only(left: gap),
                width: dashedLength,
                color: color,
              ),
            ),
          );
  }
}
