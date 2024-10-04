import 'package:flutter/material.dart';
import 'package:weather_009/apptheme/apptheme.dart';

class LocationWidgets extends StatelessWidget {
  const LocationWidgets({super.key});

  Widget locationIcon() {
    return const Icon(Icons.add_location, color: Colors.black);
  }

  Widget location(String city, String countryName) {
    return Expanded(
      child: Text(
        "$city , $countryName",
        style:AppTheme.mediumTextStyle,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        locationIcon(),
        const SizedBox(width: 8), // Space between icon and text
        location('London', 'UK'),
      ],
    );
  }
}
