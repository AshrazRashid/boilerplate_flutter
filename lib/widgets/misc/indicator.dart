import 'package:flutter/material.dart';

class Indicator extends StatefulWidget {
  final int length;
  final int selectedIndex;
  const Indicator(
      {super.key, required this.length, required this.selectedIndex});

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          widget.length,
          (index) => Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.selectedIndex == index
                      ? Colors.white
                      : Colors.white24,
                ),
              )).toList(),
    );
  }
}
