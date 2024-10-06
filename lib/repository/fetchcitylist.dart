import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_009/models/citymodel.dart';

class FetchCity {
  final String apiKey = 'a99b3b9a23adbd96f8b702b674b448e5';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/find';

  // Debounce mechanism (optional)
  Duration debounceDuration = Duration(milliseconds: 300);
  DateTime? lastQueryTime;

  // Function to fetch cities and their weather info together
  Future<List<City>> fetchCitiesWithWeather(String query) async {
    final String cityUrl =
        '$baseUrl?q=$query&appid=$apiKey&units=metric&limit=10'; // Fetch cities and weather data at once

    try {
      // Debouncing: Check if a minimum time has passed since the last query
      if (lastQueryTime != null &&
          DateTime.now().difference(lastQueryTime!) < debounceDuration) {
        return []; // Skip API call if the debounce condition isn't met
      }
      lastQueryTime = DateTime.now();

      // Fetch data from the API
      final response = await http.get(Uri.parse(cityUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data); // Check the API response in console

        // Extract cities and their weather data from API response
        if (data['list'] != null && data['list'] is List) {
          List<City> cities = (data['list'] as List).map((cityJson) {
            return City.fromJson(cityJson); // Parsing each city
          }).toList();

          return cities; // Return the list of cities along with their weather data
        } else {
          return [];
        }
      } else {
        print(
            'Error fetching cities and weather data: ${response.statusCode}, ${response.body}');
        throw Exception('Failed to fetch cities: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Error fetching cities and weather data: $e');
    }
  }
}
