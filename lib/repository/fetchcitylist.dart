import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_009/models/citymodel.dart'; // Ensure your model is correctly imported.

class FetchCity {
  final String apiKey = 'a99b3b9a23adbd96f8b702b674b448e5'; 
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/find';

  Future<List<City>> fetchCities(String query) async {
    final String cityUrl = '$baseUrl?q=$query&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(cityUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<City> cities = [];

        // Check if the 'list' key exists in the response
        if (data['list'] != null) {
          for (var city in data['list']) {
            cities.add(City(
              name: city['name'],
              country: city['sys']['country'],
              latitude: city['coord']['lat'], // Correctly accessing latitude
              longitude: city['coord']['lon'], // Correctly accessing longitude
            ));
          }
        }

        return cities; // Return the list of cities with all required information
      } else {
        print('Error fetching cities data: ${response.statusCode}, ${response.body}');
        throw Exception('Failed to fetch cities: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Error fetching cities: $e');
    }
  }
}
