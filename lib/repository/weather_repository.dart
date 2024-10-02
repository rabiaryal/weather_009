import 'dart:convert';

import 'package:weather_009/models/jsonmodels.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  Future<WeatherModel> fetchWeathers(String lat, String lon) async {
    String weatherUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=a99b3b9a23adbd96f8b702b674b448e5';

    final response = await http.get(Uri.parse(weatherUrl));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return WeatherModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }
}
