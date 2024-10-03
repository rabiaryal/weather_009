import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_009/models/countrymodel.dart';

class CountryService {
  Future<List<Country>> fetchCountries() async {
    try {
      final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('API Response: $data'); // Log the entire response

        // Map the response data to Country model and print lat/lon
        List<Country> countries = data.map((country) {
          Country countryModel = Country.fromJson(country);
          
          // Assuming the model has properties for latitude and longitude
          print('Country: ${countryModel.countryname}, Latitude: ${countryModel.latitude}, Longitude: ${countryModel.longitude}');
          
          return countryModel;
        }).toList();

        return countries;
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      print('Error in fetchCountries: $e'); // Debugging line
      throw Exception('Error fetching countries: $e');
    }
  }
}
