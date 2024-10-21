import 'package:flutter/material.dart';
import 'package:weather_009/res/apptheme/apptheme.dart';

class LocationWidgets extends StatelessWidget {
  final String? cityName;
  final String? countryName;

  const LocationWidgets({super.key, this.cityName, required this.countryName});

  Widget locationIcon() {
    return const Icon(Icons.location_on, color: Colors.black);
  }

  Widget locationDisplay() {
    return Expanded(
      child: Text(
        cityName != null && cityName!.isNotEmpty 
          ? "$cityName, $countryName"
          : countryName ?? "Unknown Location",
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
        locationDisplay(),
      ],
    );
  }
}
