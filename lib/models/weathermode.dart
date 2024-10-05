class WeatherSummary {
  final double temp; // Current temperature
  final double tempMax; // Maximum temperature
  final double tempMin; // Minimum temperature
  final double feelsLike; // Feels like temperature
  final int? humidity; // Humidity (optional)
  final double? windSpeed; // Wind speed (optional)

  WeatherSummary({
    required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.feelsLike,
    this.humidity, // humidity is optional and can be null
    this.windSpeed, // windSpeed is optional and can be null
  });

  // Factory constructor to create an instance from JSON, with null checks
  factory WeatherSummary.fromJson(Map<String, dynamic> json) {
    return WeatherSummary(
      temp: (json['main']['temp'] as num?)?.toDouble() ?? 0.0, // Ensure temp is double, default to 0.0 if null
      tempMax: (json['main']['temp_max'] as num?)?.toDouble() ?? 0.0, // Ensure tempMax is double, default to 0.0
      tempMin: (json['main']['temp_min'] as num?)?.toDouble() ?? 0.0, // Ensure tempMin is double, default to 0.0
      feelsLike: (json['main']['feels_like'] as num?)?.toDouble() ?? 0.0, // Ensure feelsLike is double, default to 0.0
      humidity: json['main']['humidity'] != null ? (json['main']['humidity'] as int) : null, // Make humidity nullable
      windSpeed: json['wind'] != null && json['wind']['speed'] != null
          ? (json['wind']['speed'] as num?)?.toDouble() // Ensure wind speed is double, handle null
          : null,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'temp_max': tempMax,
      'temp_min': tempMin,
      'feels_like': feelsLike,
      'humidity': humidity,
      'wind': {
        'speed': windSpeed,
      },
    };
  }
}
