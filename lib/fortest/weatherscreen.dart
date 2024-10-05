import 'package:flutter/material.dart';
import 'package:weather_009/models/citymodel.dart';
import 'package:weather_009/models/weathermode.dart';
import 'package:weather_009/repository/new_weatherRepo.dart';

class WeatherScreen extends StatefulWidget {
  final City city; // Receive the City object from the previous screen

  const WeatherScreen({required this.city});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<WeatherSummary>? weatherFuture;

  @override
  void initState() {
    super.initState();
    final WeatherDetails weatherDetails = WeatherDetails(); // Create an instance of WeatherDetails
    
    // Check if latitude or longitude are null
    if (widget.city.latitude != null && widget.city.longitude != null) {
      weatherFuture = weatherDetails.fetchWeather(widget.city.latitude!, widget.city.longitude!);
    } else {
      // If latitude or longitude is null, set weatherFuture to null
      weatherFuture = null;
      print('Error: City coordinates are missing.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Info'),
      ),
      body: weatherFuture != null
          ? FutureBuilder<WeatherSummary>(
              future: weatherFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  WeatherSummary weather = snapshot.data!; // Get the WeatherSummary
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('City: ${widget.city.name}, ${widget.city.country}', style: const TextStyle(fontSize: 18)),
                        Text('Temperature: ${weather.temp}°C', style: const TextStyle(fontSize: 18)),
                        Text('Max Temperature: ${weather.tempMax}°C', style: const TextStyle(fontSize: 18)),
                        Text('Min Temperature: ${weather.tempMin}°C', style: const TextStyle(fontSize: 18)),
                        Text('Feels Like: ${weather.feelsLike}°C', style: const TextStyle(fontSize: 18)),
                        Text('Humidity: ${weather.humidity ?? "N/A"}%', style: const TextStyle(fontSize: 18)),
                        if (weather.windSpeed != null) // Display wind speed only if available
                          Text('Wind Speed: ${weather.windSpeed} m/s', style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  );
                }
                return Container();
              },
            )
          : const Center(
              child: Text(
                'City coordinates are missing, unable to fetch weather.',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
    );
  }
}
