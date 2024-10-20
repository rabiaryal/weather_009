import 'package:flutter/material.dart';

class TemperatureWidgets extends StatelessWidget {
  final double temperature;

  const TemperatureWidgets({super.key, required this.temperature});

  Widget getTemperature() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          temperature.toStringAsFixed(1),
          style: const TextStyle(fontSize: 70),
        ),
        const Text(
          '°C', // Display the degree symbol for Celsius
          style: TextStyle(fontSize: 50),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 300,
      child: getTemperature(),
    );
  }
}
