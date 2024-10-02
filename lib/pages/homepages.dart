import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_009/func/geolocator.dart';

import 'package:weather_009/models/jsonmodels.dart';
import 'package:weather_009/repository/weather_repository.dart';
import 'package:weather_009/widgets/first_widgets.dart';
import 'package:weather_009/widgets/searchwidgets.dart';
import 'package:weather_009/widgets/second_dialog.dart';

class Homepages extends StatefulWidget {
  const Homepages({super.key});

  @override
  State<Homepages> createState() => _HomepagesState();
}

class _HomepagesState extends State<Homepages> {
  WeatherRepository weatherRepository = WeatherRepository();

  Future<WeatherModel>? weatherData;
  TextEditingController latController = TextEditingController();
  TextEditingController lonController = TextEditingController();
  Future<Position>? position;
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

        weatherData = weatherRepository.fetchWeathers(
          position.latitude.toString(),
          position.longitude.toString(),
        );
      });
    } catch (e) {
      setState(() {
        locationStatus = 'Error: $e';
      });

      print('Error occurred while fetching location: $e');
    }
  }

  // Update the weather information when the lat/lon changes
  void updateWeatherData(String lat, String lon) {
    setState(() {
      weatherData = weatherRepository.fetchWeathers(lat, lon);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Weather"),
        backgroundColor: Colors.amber,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: IconButton(
              onPressed: () {
                SecondDialog().showDialogAlertBox(context, updateWeatherData);
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
              
              CountrySearchBox(),
              const SizedBox(height: 10),
              FutureBuilder<WeatherModel>(
                future: weatherData,
                builder: (context, snapshot) {
                  // Checking if the snapshot is waiting or has an error
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return WidgetsCollection1().BuildWidgets(snapshot.data!);
                  } else {
                    return const Center(child: Text("No Data Available"));
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
    );
  }
}
