import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:society_management/constants/config.dart';
import 'package:society_management/services/app_preferences.dart';
import 'package:society_management/utils/snackbar_util.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

class Util {
  static String doubleToString(double value) => value.toInt().toString();
  static String getKeyByValue(List values, value) => values
      .firstWhere((element) => element.value == value)
      .toString()
      .split('.')
      .last;

  static List<String> generateTimeSlots(
      DateTime date, String openingTime, String closingTime,
      {bool allowPastTimes = true,
      DateFormat? displayFormat,
      List<Map<String, dynamic>> bookings = const []}) {
    DateFormat timeFormat = DateFormat.Hms(); // Change to Hms for seconds
    DateFormat displayTimeFormat = displayFormat ?? DateFormat.Hm();
    var now = DateTime.now();
    final DateTime openingDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      timeFormat.parse(openingTime).hour,
      timeFormat.parse(openingTime).minute,
      timeFormat.parse(openingTime).second,
    );
    final DateTime closingDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      timeFormat.parse(closingTime).hour,
      timeFormat.parse(closingTime).minute,
      timeFormat.parse(closingTime).second,
    );

    List<String> timeSlots = [];
    DateTime currentTime = openingDateTime;

    while (currentTime.isBefore(closingDateTime)) {
      if (allowPastTimes || currentTime.isAfter(now)) {
        bool isBooked = bookings.any((booking) {
          final DateTime bookingStartTime = DateTime(
            date.year,
            date.month,
            date.day,
            timeFormat.parse(booking['startTime']).hour,
            timeFormat.parse(booking['startTime']).minute,
            timeFormat.parse(booking['startTime']).second,
          );
          final DateTime bookingEndTime = DateTime(
            date.year,
            date.month,
            date.day,
            timeFormat.parse(booking['endTime']).hour,
            timeFormat.parse(booking['endTime']).minute,
            timeFormat.parse(booking['endTime']).second,
          );

          // Check if currentTime lies within an existing booking
          bool withinExistingBooking = currentTime.isBefore(bookingEndTime) &&
              currentTime
                  .add(const Duration(minutes: 30))
                  .isAfter(bookingStartTime);

          // Check if currentTime + 60 minutes lies within an existing booking
          bool overlapWithFutureBooking = currentTime
                  .add(const Duration(minutes: 60))
                  .isAfter(bookingStartTime) &&
              currentTime
                  .add(const Duration(minutes: 60))
                  .isBefore(bookingEndTime);

          return withinExistingBooking || overlapWithFutureBooking;
        });

        if (!isBooked) {
          timeSlots.add(displayTimeFormat.format(currentTime));
        }
      }
      currentTime = currentTime.add(const Duration(minutes: 30));
    }

    // Check to add the final time slot if it is valid
    if (allowPastTimes ||
        (currentTime.isAfter(now) && currentTime.isBefore(closingDateTime))) {
      bool isBooked = bookings.any((booking) {
        final DateTime bookingStartTime = DateTime(
          date.year,
          date.month,
          date.day,
          timeFormat.parse(booking['startTime']).hour,
          timeFormat.parse(booking['startTime']).minute,
          timeFormat.parse(booking['startTime']).second,
        );
        final DateTime bookingEndTime = DateTime(
          date.year,
          date.month,
          date.day,
          timeFormat.parse(booking['endTime']).hour,
          timeFormat.parse(booking['endTime']).minute,
          timeFormat.parse(booking['endTime']).second,
        );

        bool withinExistingBooking = currentTime.isBefore(bookingEndTime) &&
            currentTime
                .add(const Duration(minutes: 30))
                .isAfter(bookingStartTime);

        bool overlapWithFutureBooking = currentTime
                .add(const Duration(minutes: 60))
                .isAfter(bookingStartTime) &&
            currentTime
                .add(const Duration(minutes: 60))
                .isBefore(bookingEndTime);

        return withinExistingBooking || overlapWithFutureBooking;
      });

      if (!isBooked) {
        timeSlots.add(displayTimeFormat.format(currentTime));
      }
    }

    return timeSlots;
  }

  static String getTimeDifference(String start, String end) {
    DateTime startDateTime = DateTime.parse(start);
    DateTime endDateTime = DateTime.parse(end);

    Duration difference = endDateTime.difference(startDateTime);
    return "${difference.inMinutes} minutes";

    // int hours = difference.inHours;
    // int minutes = difference.inMinutes % 60;

    // String differenceString = '$hours hour${hours != 1 ? 's' : ''}';
    // if (minutes != 0) {
    //   differenceString += ' and $minutes minute${minutes != 1 ? 's' : ''}';
    // }
    // return differenceString;
  }

  // static List<String> generateTimeSlots(String openingTime, String closingTime,
  //     {bool allowPastTimes = true, DateFormat? displayFormat}) {
  //   DateFormat timeFormat = DateFormat.Hm();
  //   DateFormat dispalyTimeFormat = displayFormat ?? DateFormat.Hm();
  //   final DateTime now = DateTime.now();
  //   final DateTime openingDateTime = DateTime(
  //       now.year,
  //       now.month,
  //       now.day,
  //       timeFormat.parse(openingTime).hour,
  //       timeFormat.parse(openingTime).minute);
  //   final DateTime closingDateTime = DateTime(
  //       now.year,
  //       now.month,
  //       now.day,
  //       timeFormat.parse(closingTime).hour,
  //       timeFormat.parse(closingTime).minute);

  //   List<String> timeSlots = [];
  //   DateTime currentTime = openingDateTime;

  //   while (currentTime.isBefore(closingDateTime)) {
  //     if (allowPastTimes || currentTime.isAfter(now)) {
  //       timeSlots.add(dispalyTimeFormat.format(currentTime));
  //     }
  //     currentTime = currentTime.add(const Duration(minutes: 30));
  //   }

  //   // Add the closing time if it's not already in the list and it's after now
  //   if (allowPastTimes ||
  //       (currentTime.isAfter(now) &&
  //           timeFormat.format(currentTime) ==
  //               timeFormat.format(closingDateTime))) {
  //     timeSlots.add(dispalyTimeFormat.format(currentTime));
  //   }

  //   return timeSlots;
  // }

  static String getImageUrl(String? path) =>
      "${AppConfig.baseUrl}/img/upload/$path";

  static double calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371; // Radius of the Earth in kilometers
    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);
    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // Distance in kilometers
  }

  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  static DateTime mergeDateTime(DateTime date, String timeString) {
    // Parse the time string into hour and minute components
    final timeParts = timeString.split(':');
    int hour = int.parse(timeParts[0]);
    final int minute = int.parse(timeParts[1].replaceAll(RegExp(r'[^\d]'),
        '')); // Remove non-digit characters (e.g., "am", "pm")

    // Check for AM/PM format
    final isAm = timeString.toLowerCase().endsWith('am');
    final isPm = timeString.toLowerCase().endsWith('pm');

    // Handle AM/PM format (adjust hour if necessary)
    if (isAm && hour == 12) {
      hour = 0; // 12 AM is midnight
    } else if (isPm && hour != 12) {
      hour += 12; // Convert PM to 24-hour format, except for 12 PM
    }

    // Create a new DateTime object with the combined date and time
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  static void openUrl(String? url) async {
    if (url != null && url.isNotEmpty) {
      var uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }

  static void launchWhatsApp(String contact) async {
    String text = '';
    String androidUrl = "whatsapp://send?phone=$contact&text=$text";
    String iosUrl = "https://wa.me/$contact?text=${Uri.parse(text)}";

    String webUrl = 'https://api.whatsapp.com/send/?phone=$contact&text=hi';

    try {
      if (Platform.isIOS) {
        // if (await canLaunchUrl(Uri.parse(iosUrl))) {
        await launchUrl(Uri.parse(iosUrl));
        // }
      } else {
        // if (await canLaunchUrl(Uri.parse(androidUrl))) {
        await launchUrl(Uri.parse(androidUrl));
        // }
      }
    } catch (e) {
      print('object');
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    }
  }

  static void openGoogleMaps(String latitude, String longitude) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    openUrl(googleMapsUrl);
  }

  static int? extractIntFromString(String input) {
    final RegExp regex = RegExp(r'\d+');
    final Match? match = regex.firstMatch(input);

    if (match != null) {
      return int.parse(match.group(0)!);
    }

    return null;
  }

  static String getInitials(String name) {
    if (name.isEmpty) return '';

    // Split the name by spaces
    List<String> nameParts = name.trim().split(' ');

    // Get the first letter of each part
    String initials = '';
    for (String part in nameParts) {
      if (part.isNotEmpty) {
        initials += part[0].toUpperCase();
      }
    }

    return initials.length > 2 ? initials.substring(0, 2) : initials;
  }

  static List<Map<String, dynamic>> getSortedPlayers(List existingPlayers,
      {bool isDouble = true}) {
    List<Map<String, dynamic>> players = [];
    existingPlayers.sort((a, b) {
      if (a['position'] == null && b['position'] == null) return 0;
      if (a['position'] == null) return 1;
      if (b['position'] == null) return -1;
      return a['position'].compareTo(b['position']);
    });
    List<int> expectedPositions = isDouble ? [1, 2, 3, 4] : [1, 2];
    int j = 0;

    if (existingPlayers[0]['position'] == 0) {
      existingPlayers[0]['position'] = 1;
    }

    for (int i = 0; i < expectedPositions.length; i++) {
      if (j < existingPlayers.length &&
          existingPlayers[j]['position'] == expectedPositions[i]) {
        players.add(existingPlayers[j]);
        j++;
      } else {
        players.add({});
      }
    }
    return players;
  }

  static String formattedCurrency(dynamic amount, {String symbol = "Rs "}) {
    var format = NumberFormat.currency(
        locale: 'en_PK', symbol: symbol, decimalDigits: 0);
    return format.format(amount);
  }

  static bool getIsCreator(List players) {
    var user = AppPreferences.getLogin()!;
    return players.any((element) => element['playerId'] == user.id)
        ? players
            .firstWhere((player) => player['playerId'] == user.id)['iscreator']
        : false;
  }

  static String formatDate(String date, {String format = "dd MMM"}) =>
      DateFormat(format).format(DateTime.parse(date));

  static void copyToClipboard(value) async {
    await Clipboard.setData(ClipboardData(text: value));
    SnackbarUtil.info(message: "Copied to clipboard");
  }

  static Map<String, dynamic> convertToMapStringDynamic(
      Map<dynamic, dynamic> inputMap) {
    if (inputMap is Map<String, dynamic>) {
      return inputMap;
    }

    return inputMap.map((key, value) {
      return MapEntry(key.toString(), value);
    });
  }
}
