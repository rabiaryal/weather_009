import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_009/apptheme/apptheme.dart';

class DateWidgets extends StatelessWidget {
  const DateWidgets({super.key});
  String getCurrentDateTime() {
    // Get current date and time
    DateTime now = DateTime.now();

    // Format date and time
    String formattedDate =
        DateFormat('EEEE, MMM d,').format(now); // Example: Friday, Oct 6, 2023
    String formattedTime = DateFormat('h:mm a').format(now); // Example: 5:12 PM

    return "$formattedDate $formattedTime";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getCurrentDateTime(),
      style: AppTheme.mediumTextStyle,
    );
  }
}
