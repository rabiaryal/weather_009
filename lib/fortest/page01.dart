import 'package:flutter/material.dart';
import 'package:weather_009/fortest/citysearchbox.dart';

class NextHome extends StatefulWidget {
  const NextHome({super.key});

  @override
  State<NextHome> createState() => _NextHomeState();
}

class _NextHomeState extends State<NextHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Weather"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              // Wrap the main content in Expanded to prevent infinite height
              child: SingleChildScrollView(
                child: CityDropdown(), // Call your CityDropdown widget
              ),
            ),
          ],
        ),
      ),
    );
  }
}
