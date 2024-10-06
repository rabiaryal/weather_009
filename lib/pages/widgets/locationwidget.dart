import 'package:flutter/material.dart';
import 'package:weather_009/apptheme/apptheme.dart';

class LocationWidgets extends StatelessWidget {
  final String? city;
  final String? countryName;

  const LocationWidgets({Key? key, required this.city, required this.countryName}) : super(key: key);

  Widget locationIcon() {
    return const Icon(Icons.location_on, color: Colors.black);
  }

  Widget location(String? city, String? countryName) {
    return Expanded(
      child: Text(
        "$city, $countryName",
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
        location(city, countryName),
      ],
    );
  }
}
