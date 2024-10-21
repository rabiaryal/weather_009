import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_009/models/countrymodel.dart';
import 'dart:math'; // For distance calculation

class CountryService {
  Future<List<Country>> fetchCountries() async {
    try {
      final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('API Response: $data'); // Log the entire response

        // Map the response data to Country model
        List<Country> countries = data.map((country) {
          Country countryModel = Country.fromJson(country);
          print('Country: ${countryModel.countryname}, Latitude: ${countryModel.latitude}, Longitude: ${countryModel.longitude}');
          return countryModel;
        }).toList();

        return countries;
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      print('Error in fetchCountries: $e');
      throw Exception('Error fetching countries: $e');
    }
  }

  // New method to fetch the closest country based on lat/long
  Future<Country> fetchCountryByLatLong({
    required double latitude,
    required double longitude,
  }) async {
    try {
      // Fetch the list of all countries
      List<Country> countries = await fetchCountries();

      // Find the country with the closest latitude/longitude match
      Country? closestCountry;
      double closestDistance = double.infinity;

      for (Country country in countries) {
        double distance = _calculateDistance(
          latitude,
          longitude,
          country.latitude,
          country.longitude,
        );

        if (distance < closestDistance) {
          closestDistance = distance;
          closestCountry = country;
        }
      }

      if (closestCountry != null) {
        return closestCountry;
      } else {
        throw Exception('No country found for the given latitude and longitude.');
      }
    } catch (e) {
      print('Error fetching country by lat/long: $e');
      throw Exception('Error fetching country by latitude/longitude: $e');
    }
  }

  // Helper method to calculate the distance between two lat/long points
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double p = 0.017453292519943295; // Pi/180 for radian conversion
    const double earthRadius = 6371; // Radius of Earth in kilometers

    final double a = 0.5 - cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) *
        (1 - cos((lon2 - lon1) * p)) / 2;

    return earthRadius * 2 * asin(sqrt(a)); // Distance in kilometers
  }
}
