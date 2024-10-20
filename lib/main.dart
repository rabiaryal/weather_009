import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_009/bloc/weather_bloc.dart'; // Import your WeatherBloc

import 'package:weather_009/models/citymodel.dart';
import 'package:weather_009/pages/firstpage.dart';



void main() {
  runApp(
    BlocProvider(
      create: (context) => WeatherBloc(),
      child: MyApp(), // This could be your root widget
    ),
  );
}

class MyApp extends StatelessWidget {
  
  @override
   City selectedCity = City(
      name: 'London',
      country: 'UK',
      latitude: 51.5074,
      longitude: -0.1278,
    );
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: FirstPage(selectedCity: selectedCity), // CitySearchBox widget
    );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Example city to pass to FirstPage
//     City selectedCity = City(
//       name: 'London',
//       country: 'UK',
//       latitude: 51.5074,
//       longitude: -0.1278,
//     );
    

//     return BlocProvider(
//       create: (context) => WeatherBloc(), // Provide your WeatherBloc here
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: FirstPage(selectedCity: selectedCity), // Pass the city to FirstPage
//       ),
//     );
//   }
// }
