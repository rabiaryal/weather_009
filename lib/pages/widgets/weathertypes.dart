import 'package:flutter/material.dart';


enum Weathertypes {
  sunny,
  cloudy,
  rain,
  snow,
}

extension WeatherFunction on Weathertypes {
  String getDescription() {
    switch (this) {
      case Weathertypes.sunny:
        return 'The weather is bright and sunny!';
      case Weathertypes.cloudy:
        return 'It is cloudy with a chance of gloom.';
      case Weathertypes.rain:
        return 'It is raining bring an umbrella!';
      case Weathertypes.snow:
        return 'Snow is falling, it\'s going to be chilly!';
    }
  }
    IconData getIcon() {
    switch (this) {
      case Weathertypes.sunny:
        return Icons.wb_sunny; // Use relevant icons for each weather type
      case Weathertypes.cloudy:
        return Icons.cloud;
      case Weathertypes.rain:
        return Icons.umbrella;
      case Weathertypes.snow:
        return Icons.ac_unit; // Snowflake icon
    }
  }


  Color getBackgroundColor() {
    switch (this) {
      case Weathertypes.sunny:
        return Colors.yellow;
      case Weathertypes.cloudy:
        return Colors.grey;
      case Weathertypes.rain:
        return Colors.blue;
      case Weathertypes.snow:
        return Colors.lightBlue.shade100;
    }
  }


}
