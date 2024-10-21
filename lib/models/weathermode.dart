import 'package:weather_009/pages/widgets/weathertypes.dart';

 // Import the Weathertypes enum

class WeatherSummary {
  final double temp; // Current temperature
  final double tempMax; // Maximum temperature
  final double tempMin; // Minimum temperature
  final double feelsLike; // Feels like temperature
  final int? humidity; // Humidity (optional)
  final double? windSpeed; // Wind speed (optional)
  final int utcTime; // UTC time (Unix timestamp)
  final int timezoneOffset; // Timezone offset in seconds
  final Weathertypes weatherType; // Weather type (added field)

  WeatherSummary({
    required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.feelsLike,
    this.humidity,
    this.windSpeed,
    required this.utcTime,
    required this.timezoneOffset,
    required this.weatherType, // Required weather type
  });

  // Factory constructor to create an instance from JSON, with null checks
  factory WeatherSummary.fromJson(Map<String, dynamic> json) {
    return WeatherSummary(
      temp: (json['main']['temp'] as num?)?.toDouble() ?? 0.0,
      tempMax: (json['main']['temp_max'] as num?)?.toDouble() ?? 0.0,
      tempMin: (json['main']['temp_min'] as num?)?.toDouble() ?? 0.0,
      feelsLike: (json['main']['feels_like'] as num?)?.toDouble() ?? 0.0,
      humidity: json['main']['humidity'] != null ? (json['main']['humidity'] as int) : null,
      windSpeed: json['wind'] != null && json['wind']['speed'] != null
          ? (json['wind']['speed'] as num?)?.toDouble()
          : null,
      utcTime: json['dt'] as int,
      timezoneOffset: json['timezone'] as int,
      weatherType: _mapWeatherConditionToType(json['weather']?[0]['main'] as String?), // Map weather type
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'main': {
        'temp': temp,
        'temp_max': tempMax,
        'temp_min': tempMin,
        'feels_like': feelsLike,
        'humidity': humidity,
      },
      'wind': {
        'speed': windSpeed,
      },
      'dt': utcTime,
      'timezone': timezoneOffset,
      'weather': [
        {
          'main': weatherType.name, // Convert weatherType back to string for JSON
        }
      ],
    };
  }

  // Helper method to map weather condition strings from the API to Weathertypes enum
  static Weathertypes _mapWeatherConditionToType(String? weatherCondition) {
    switch (weatherCondition?.toLowerCase()) {
      case 'clear':
        return Weathertypes.sunny;
      case 'clouds':
        return Weathertypes.cloudy;
      case 'rain':
      case 'drizzle':
        return Weathertypes.rain;
      case 'snow':
        return Weathertypes.snow;
      case 'fog':
      case 'mist':
        return Weathertypes.fog;
      case 'thunderstorm':
        return Weathertypes.thunderstorm;
      case 'wind':
        return Weathertypes.wind;
      default:
        return Weathertypes.cloudy; // Default case for unknown weather types
    }
  }
}
