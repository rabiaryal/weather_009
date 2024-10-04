import 'package:flutter/material.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatelessWidget {
  const WeatherHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4B0082), Color(0xFF8A2BE2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Location and Temperature
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'London, UK',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '16° C',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 64,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Mostly Cloudy',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              // Additional Information
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _infoCard(
                        Icons.access_time, '23:00', 'Slight chance of rain'),
                    _infoCard(Icons.air, '14 km/h', 'Gentle breeze now'),
                    _infoCard(Icons.sunny, 'UV 12', 'Low sunburn risk today'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Hourly Forecast
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Hourly Forecast',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              const SizedBox(height: 10),
              // Hourly Forecast Data
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _hourlyForecast('05:00', '23°', Icons.wb_sunny),
                    _hourlyForecast('06:00', '20°', Icons.cloud),
                    _hourlyForecast('07:00', '17°', Icons.cloud),
                    _hourlyForecast('08:00', '16°', Icons.cloud),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _infoCard(IconData icon, String title, String subtitle) {
    return Card(
      color: Colors.white54,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.blue, size: 30),
            const SizedBox(height: 5),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  static Widget _hourlyForecast(
      String time, String temperature, IconData icon) {
    return SizedBox(
      width: 70,
      child: Column(
        children: [
          Text(time, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 5),
          Icon(icon, color: Colors.white),
          const SizedBox(height: 5),
          Text(temperature, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
