import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_009/models/jsonmodels.dart'; // Ensure your model is correctly imported.

class WeatherRepository {
  final String apiKey = 'a99b3b9a23adbd96f8b702b674b448e5'; 
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherModel> fetchWeathers(double latitude, double longitude) async {
    // Make sure latitude and longitude are double types
    final String weatherUrl = '$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(weatherUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        print('API Response: $body');
        
        print('Fetching weather for lat: $latitude, lon: $longitude');
 // Log the response
        return WeatherModel.fromJson(body);
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
