import 'dart:async';
import 'dart:ui';

class Throttler {
  int milliseconds;
  Timer? _timer;
  bool _isReady = true;

  Throttler({required this.milliseconds});

  void run(VoidCallback action) {
    if (_isReady) {
      // Prevent any further action for the throttle duration
      _isReady = false;

      // Trigger the action immediately
      action();

      // Start the timer to reset _isReady after the specified duration
      _timer =
          Timer(Duration(milliseconds: milliseconds), () => _isReady = true);
    } else {
      // Optionally, you can print a message or handle blocked taps
      print("Action blocked due to throttle.");
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}
