import 'package:flutter/material.dart';
import 'package:weather_009/pages/firstpage.dart';
import 'package:weather_009/pages/widgets/locationwidget.dart';
import 'package:weather_009/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:FirstPage(),
    );
  }
}
