import 'package:flutter/material.dart';
import 'package:weather_009/res/apptheme/apptheme.dart';

class LocationWidgets extends StatelessWidget {
  // final String? city;
  final String? countryName;

  const LocationWidgets({super.key,  required this.countryName});

  Widget locationIcon() {
    return const Icon(Icons.location_on, color: Colors.black);
  }

  Widget location( String? countryName) {
    return Expanded(
      child: Text(
        " $countryName",
        style: AppTheme.mediumTextStyle,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        locationIcon(),
        const SizedBox(width: 8),
        location(countryName),
      ],
    );
  }
}
