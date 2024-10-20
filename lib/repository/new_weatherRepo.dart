import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_009/models/weathermode.dart'; // Ensure your model is correctly imported.

class WeatherDetails {
  final String apiKey = '70dfe8efe5d56cff4e48055df5b5b8f5'; // Add your API key

 
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherSummary> fetchWeather(double latitude, double longitude) async {
    final String weatherUrl = '$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(weatherUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        print('API Response: $body');
        
        // Log the response
        return WeatherSummary.fromJson(body);
      } else {
        print('Error fetching weather data: ${response.statusCode}, ${response.body}');
        throw Exception('Failed to fetch weather data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      print('Exception: $e');
      throw Exception('Error fetching weather data: $e');
    }
  }
}
