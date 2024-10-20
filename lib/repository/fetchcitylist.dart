import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_009/models/citymodel.dart';

class FetchCity {
  final String apiKey = '70dfe8efe5d56cff4e48055df5b5b8f5'; // Add your API key

  final String baseUrl = 'https://api.openweathermap.org/data/2.5/find';

  // Debounce mechanism (optional)
  Duration debounceDuration = const Duration(milliseconds: 300);
  DateTime? lastQueryTime;

  // Function to fetch cities and their weather info together
  Future<List<City>> fetchCitiesWithWeather(String query) async {
    final String cityUrl =
        '$baseUrl?q=$query&appid=$apiKey&units=metric&limit=10'; // Fetch cities

    try {
      // Fetch data from the API
      final response = await http.get(Uri.parse(cityUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data); // Check the API response in console

        // Extract cities from the API response
        if (data['list'] != null && data['list'] is List) {
          List<City> cities = (data['list'] as List).map((cityJson) {
            return City.fromJson(cityJson); // Parsing each city
          }).toList();

          return cities; // Return the list of cities
        } else {
          return []; // Return an empty list if no cities found
        }
      } else {
        print(
            'Error fetching cities: ${response.statusCode}, ${response.body}');
        throw Exception('Failed to fetch cities: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Error fetching cities: $e');
    }
  }
}
