import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_009/res/apptheme/apptheme.dart';

class DateWidgets extends StatelessWidget {

  final DateTime utcTime;
  // UTC time (from the API)
  final int timezoneOffset; // Timezone offset in seconds

  const DateWidgets({
    Key? key,
    required this.utcTime,
    required this.timezoneOffset,
  }) : super(key: key);

  // Function to calculate local time based on UTC and timezone offset
  String getLocalDateTime() {
    // Convert the UTC time to local time based on timezone offset
    DateTime localTime = utcTime.add(Duration(seconds: timezoneOffset));

    // Format date and time for the selected country
    String formattedDate = DateFormat('EEEE, MMM d,').format(localTime); // Example: Friday, Oct 6, 2023
    String formattedTime = DateFormat('h:mm a').format(localTime); // Example: 5:12 PM

    return "$formattedDate $formattedTime";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getLocalDateTime(),
      style: AppTheme.mediumTextStyle,
    );
  }
}
