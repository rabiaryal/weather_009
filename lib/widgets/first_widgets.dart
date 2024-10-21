import 'package:flutter/material.dart';
import 'package:weather_009/models/jsonmodels.dart';
import 'package:weather_009/repository/weather_repository.dart';

class WidgetsCollection1 {
  WeatherRepository weatherRepository = WeatherRepository();

  Widget textFormField(TextEditingController controller, String name) {
    return TextFormField(
      controller: controller,
      // keyboardType: TextInputType,
      decoration: InputDecoration(
        hintText: "Enter $name",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }

  Widget roundButton(
      BuildContext context, String name, String funcName, Function onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Text(name),
    );
  }

  Widget BuildWidgets(WeatherModel weather) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Location: ${weather.name ?? 'Unknown'}',
              style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          weather.weather != null && weather.weather!.isNotEmpty
              ? Text('Weather: ${weather.weather![0].description ?? 'Unknown'}',
                  style: const TextStyle(fontSize: 18))
              : const Text('Weather: Unknown', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          weather.main != null
              ? Text(
                  'Temperature: ${kelvinToCelsius(weather.main!.temp!).toStringAsFixed(1)}°C',
                  style: const TextStyle(fontSize: 18),
                )
              : const Text('Temperature: Unknown',
                  style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          weather.main != null
              ? Text('Humidity: ${weather.main!.humidity}%',
                  style: const TextStyle(fontSize: 18))
              : const Text('Humidity: Unknown', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          weather.wind != null
              ? Text('Wind Speed: ${weather.wind!.speed} m/s',
                  style: const TextStyle(fontSize: 18))
              : const Text('Wind Speed: Unknown',
                  style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          weather.clouds != null
              ? Text('Cloudiness: ${weather.clouds!.all}%',
                  style: const TextStyle(fontSize: 18))
              : const Text('Cloudiness: Unknown',
                  style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  double kelvinToCelsius(num kelvin) {
    return kelvin.toDouble() - 273.15;
  }
}
