import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_009/bloc/weather_bloc.dart';
import 'package:weather_009/models/countrymodel.dart'; // Import your Country model
import 'package:weather_009/utils/func/geolocator.dart'; // Import your geolocation methods
import 'firstpage.dart'; // Import your FirstPage
import 'package:geocoding/geocoding.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _fetchCurrentLocationAndFetchWeather();
  }

  Future<void> _fetchCurrentLocationAndFetchWeather() async {
    try {
      Position position = await determinePosition();
      await _fetchWeatherForLocation(position.latitude, position.longitude);
    } catch (e) {
      print("Error fetching current location: $e");
      // Use default location if unable to fetch current location
      await _fetchWeatherForDefaultLocation();
    }
  }

  Future<void> _fetchWeatherForLocation(double latitude, double longitude) async {
    try {
      // Get the country information from the coordinates
      Country country = await getCountryFromCoordinates(latitude, longitude);

      // Dispatch the SelectCountryEvent to update the BLoC state
      context.read<WeatherBloc>().add(SelectCountryEvent(selectedCountry: country));

      // Navigate to the FirstPage after updating the country
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FirstPage()),
      );
    } catch (e) {
      print("Error fetching weather for location: $e");
      // Handle error appropriately, e.g., show a dialog or message to the user
    }
  }

  Future<void> _fetchWeatherForDefaultLocation() async {
    // Define a default location (e.g., latitude and longitude for a city)
    const double defaultLatitude = 27.7172; // Example: Kathmandu
    const double defaultLongitude = 85.324; // Example: Kathmandu

    // Get the country information for the default location
    try {
      Country country = await getCountryFromCoordinates(defaultLatitude, defaultLongitude);
      context.read<WeatherBloc>().add(SelectCountryEvent(selectedCountry: country));

      // Navigate to the FirstPage after updating the country
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FirstPage()),
      );
    } catch (e) {
      print("Error fetching weather for default location: $e");
      // Handle error appropriately
    }
  }

  Future<Country> getCountryFromCoordinates(double latitude, double longitude) async {
    // Get the list of placemarks from the coordinates
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    
    // Check if placemarks are available
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0]; // Get the first placemark
      // Create and return a Country object
      return Country(
        countryname: placemark.country ?? 'Unknown Country', // Use country or set a default
        latitude: latitude, // Pass the latitude
        longitude: longitude, // Pass the longitude
        flagUrl: 'default_flag_url', // Provide a default URL for flagUrl
      );
    } else {
      throw Exception('No country found for the given coordinates');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: CircularProgressIndicator(), // Show a loading indicator while fetching location
      ),
    );
  }
}
