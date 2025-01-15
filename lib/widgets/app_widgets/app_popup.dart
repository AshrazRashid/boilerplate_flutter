import 'package:flutter/material.dart';

class AppPopup extends StatelessWidget {
  const AppPopup(
      {super.key, required this.child, this.hideOnOutsideTap = true});
  final Widget child;
  final bool hideOnOutsideTap;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          radius: 0,
          highlightColor: Colors.transparent,
          onTap: () {
            if (hideOnOutsideTap) {
              Navigator.pop(context);
            }
          },
          child: Center(
              child: IntrinsicHeight(
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: child),
          )),
        ));
  }
}
