import 'dart:convert';
import 'package:weather_009/models/weathermode.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  final String apiKey = '70dfe8efe5d56cff4e48055df5b5b8f5'; // Add your API key

  Future<WeatherSummary> fetchWeathers(String cityName) async {
    if (cityName == null || cityName.isEmpty) {
      throw Exception('City name is required');
    }
    final String weatherUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(weatherUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherSummary.fromJson(data);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
