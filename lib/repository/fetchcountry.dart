import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryService {
  Future<List<String>> fetchCountries() async {
    final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      List<dynamic> countries = json.decode(response.body);
      return countries.map((country) => country['name']['common'] as String).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
