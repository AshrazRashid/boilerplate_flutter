import 'package:flutter/material.dart';
import '../misc/misc_widget.dart';

class ConfirmationDialog extends StatefulWidget {
  final Function onConfirm;
  final IconData icon;
  final String confirmBtnText;
  final String message;

  ConfirmationDialog(
      {super.key,
      required this.onConfirm,
      required this.icon,
      required this.confirmBtnText,
      required this.message});

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TweenAnimationBuilder<double>(
              tween: Tween(begin: -0.75, end: 0.05),
              duration: const Duration(milliseconds: 500),
              curve: Curves.bounceInOut,
              builder: (context, value, child) {
                return Transform.rotate(
                  angle: value,
                  child: child,
                );
              },
              child: Icon(
                widget.icon,
                size: 55,
                color: Colors.red,
              ),
            ),
            const AppSpacerH(10),
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const AppSpacerH(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black38),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onConfirm(); // Call the provided callback function
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text(widget.confirmBtnText,
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
