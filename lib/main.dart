import 'package:flutter/material.dart';
import 'package:weather_009/fortest/page01.dart';
import 'package:weather_009/models/citymodel.dart';
import 'package:weather_009/pages/firstpage.dart';
import 'package:weather_009/pages/homepages.dart';

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

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NextHome() // Passing the city to FirstPage
    );
  }
}
