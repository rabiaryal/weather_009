import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_009/models/countrymodel.dart';
import 'package:weather_009/pages/firstpage/weatherpagecontent.dart';

import 'package:weather_009/pages/widgets/weathertypes.dart';
import 'package:weather_009/bloc/weather_bloc.dart';
import 'package:weather_009/res/extensions/enums.dart';
import 'package:weather_009/utils/func/geolocator.dart';
import 'package:weather_009/utils/loading_widget.dart';



class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Weathertypes currentWeather = Weathertypes.cloudy;
  String cityName = 'Loading...'; // Placeholder for city name
  String countryName = 'Loading...'; // Placeholder for country name

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialLocationOrCity();
    });
  }

  Future<void> _fetchInitialLocationOrCity() async {
    try {
      // Fetch location
      Position position = await determinePosition();

      // Reverse geocoding to get the city and country name
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      
      Placemark place = placemarks[0];
      cityName = place.locality ?? 'Unknown City';
      countryName = place.country ?? 'Unknown Country';

      // Fetch weather based on coordinates
      Country selectedCountry = await context.read<WeatherBloc>().countryService.fetchCountryByLatLong(
            latitude: position.latitude,
            longitude: position.longitude,
          );

      // Update Bloc with the fetched country and city name
      context.read<WeatherBloc>().add(FetchWeatherEvent(
        selectedCountry: selectedCountry,
        // cityName: cityName,
      ));

      setState(() {});
    } catch (e) {
      print('Error fetching location: $e');
      context.read<WeatherBloc>().add(FetchWeatherByCityEvent(cityName: 'New York'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherStates>(
      builder: (context, state) {
        if (state.postApiStatus == PostApiStatus.loading) {
          return const Center(child: LoadingWidget());
        } else if (state.postApiStatus == PostApiStatus.success && state.weatherDetails != null) {
          return WeatherPageContent(state: state,  );
        } else if (state.postApiStatus == PostApiStatus.error) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else {
          return const Center(child: LoadingWidget());
        }
      },
    );
  }
}


// class FirstPage extends StatefulWidget {
//   const FirstPage({super.key});

//   @override
//   State<FirstPage> createState() => _FirstPageState();
// }

// class _FirstPageState extends State<FirstPage> {
//   Weathertypes currentWeather = Weathertypes.cloudy;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch initial data after the widget is fully mounted
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _fetchInitialLocationOrCity();
//     });
//   }

//   Future<void> _fetchInitialLocationOrCity() async {
//     try {
//       // Fetch location-based weather
//       Position position = await determinePosition();
//       Country selectedCountry = await context.read<WeatherBloc>().countryService.fetchCountryByLatLong(
//             latitude: position.latitude,
//             longitude: position.longitude,
//           );

//       // Trigger FetchWeatherEvent using the Bloc
//       context.read<WeatherBloc>().add(FetchWeatherEvent(selectedCountry: selectedCountry));
//     } catch (e) {
//       print('Error fetching location: $e');

//       // If an error occurs, fallback to fetching weather for a default city (e.g., New York)
//       context.read<WeatherBloc>().add(FetchWeatherByCityEvent(cityName: 'New York'));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<WeatherBloc, WeatherStates>(
//       builder: (context, state) {
//         if (state.postApiStatus == PostApiStatus.loading) {
//           return const Center(child: LoadingWidget());
//         } else if (state.postApiStatus == PostApiStatus.success && state.weatherDetails != null) {
//           return WeatherPageContent(state: state);
//         } else if (state.postApiStatus == PostApiStatus.error) {
//           return Center(child: Text('Error: ${state.errorMessage}'));
//         } else {
//           return const Center(child: LoadingWidget());
//         }
//       },
//     );
//   }
// }
