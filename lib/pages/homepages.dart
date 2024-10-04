import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_009/bloc/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_009/extensions/enums.dart';

import 'package:weather_009/models/jsonmodels.dart';
import 'package:weather_009/repository/fetchcountry.dart';
import 'package:weather_009/repository/weather_repository.dart';
import 'package:weather_009/widgets/first_widgets.dart';
import 'package:weather_009/widgets/searchwidgets.dart';

class Homepages extends StatefulWidget {
  const Homepages({super.key});

  @override
  State<Homepages> createState() => _HomepagesState();
}

class _HomepagesState extends State<Homepages> {
  WeatherRepository weatherRepository = WeatherRepository();
  Future<WeatherModel>? weatherData;
  Position? _defaultPosition;
  String locationStatus = "Fetching location...";

  @override
  void initState() {
    super.initState();
    weatherData = null;
    initilizeLocation();
  }

  Future<void> initilizeLocation() async {
    try {
      Position position = await determinePosition();
      setState(() {
        _defaultPosition = position;
        locationStatus =
            'Default Location Set: (${position.latitude}, ${position.longitude})';

        // Fetch weather data using the retrieved coordinates
        weatherData = weatherRepository.fetchWeathers(
          position.latitude,
          position.longitude,
        );
      });
    } catch (e) {
      setState(() {
        locationStatus = 'Error: $e';
      });
    }
  }

  // Function to determine the device's current position
  Future<Position> determinePosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      
      create: (context) => WeatherBloc(
        countryService: CountryService(),
        weatherRepository: WeatherRepository(),
      )..add(const LoadCountry()), // Load the list of countries on initialization
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Weather"),
          backgroundColor: Colors.amber,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: IconButton(
                onPressed: () {
                  // Trigger fetching location-based weather
                  initilizeLocation();
                },
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CountrySearchBox(), // This will use the BLoC to fetch country data and handle selection
                const SizedBox(height: 10),
                BlocBuilder<WeatherBloc, WeatherStates>(
                  builder: (context, state) {

                     switch (state.postApiStatus) {
      case PostApiStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case PostApiStatus.success:
        if (state.weatherDetails != null) {
          return WidgetsCollection1().BuildWidgets(state.weatherDetails!);
        }
        return const Center(child: Text("No Weather Data Available"));
      case PostApiStatus.error:
        return const Center(child: Text("Error fetching weather data, this is form the post Api statues"));
      default:
        return const Center(child: Text("Unknown state"));
    }
                    
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            initilizeLocation();
          },
          child: const Icon(Icons.refresh_outlined),
        ),
      ),
    );
  }
}
