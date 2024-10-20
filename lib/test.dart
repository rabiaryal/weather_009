import 'package:flutter/material.dart';

class TemperatureWidget extends StatelessWidget {
  final int temperature;

  const TemperatureWidget({super.key, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Temperature Value
        Text(
          '$temperature',
          style: const TextStyle(
            fontSize: 100, // Large font size for temperature
            fontWeight: FontWeight.bold,
          ),
        ),
        // Degree Celsius Symbol
        const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '°', // Degree symbol
              style: TextStyle(
                fontSize: 40, // Smaller font size for degree symbol
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'C', // Celsius symbol
              style: TextStyle(
                fontSize: 30, // Smaller font size for 'C'
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}