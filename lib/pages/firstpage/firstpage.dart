import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    _fetchInitialLocationOrCity();
  }

  Future<void> _fetchInitialLocationOrCity() async {
    try {
      // Fetch location-based weather
      Position position = await determinePosition();
      Country selectedCountry = await context.read<WeatherBloc>().countryService.fetchCountryByLatLong(
            latitude: position.latitude,
            longitude: position.longitude,
          );

      context.read<WeatherBloc>().add(FetchWeatherEvent(selectedCountry: selectedCountry));
    } catch (e) {
      print('Error fetching location: $e');
      // Fallback: Fetch weather for a default city (e.g., "New York")
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
          return WeatherPageContent(state: state);
        } else if (state.postApiStatus == PostApiStatus.error) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else {
          return const Center(child: LoadingWidget());
        }
      },
    );
  }
}
