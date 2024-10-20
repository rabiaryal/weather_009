import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_009/bloc/weather_bloc.dart'; // Import your WeatherBloc


import 'package:weather_009/pages/homepages.dart';
import 'package:weather_009/repository/fetchcountry.dart';
import 'package:weather_009/repository/weather_repository.dart';




void main() {
  runApp(
    BlocProvider(
      create: (context) => WeatherBloc(weatherRepository: WeatherRepository(), countryService: CountryService()),
      child: MyApp(), // This could be your root widget
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home:HomePage() // CitySearchBox widget
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
