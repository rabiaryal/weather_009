import 'package:flutter/material.dart';
import 'package:weather_009/models/citymodel.dart';
import 'package:weather_009/pages/firstpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Example city to pass to FirstPage
    City selectedCity = City(
      name: 'London',
      country: 'UK',
      latitude: 51.5074,
      longitude: -0.1278,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(selectedCity: selectedCity), // Passing the city to FirstPage
    );
  }
}
