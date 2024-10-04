import 'package:flutter/material.dart';

class TemperatureWidgets extends StatelessWidget {
  final double temperature; // Accept temperature as a double

  const TemperatureWidgets(
      {super.key,
      required this.temperature}); // Constructor to accept temperature

  Widget getTemperature() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          temperature.toStringAsFixed(
              1), // Convert temperature to string with 1 decimal place
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
    return Container(
      height: 200,
      width: 300,
      child: getTemperature(),
      // Uncomment the following line if you want to have a background color for better visibility
      // color: Colors.green,
    );
  }
}
