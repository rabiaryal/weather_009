import 'package:flutter/material.dart';

enum Weathertypes {
  sunny,
  cloudy,
  rain,
  snow,
  fog,
  thunderstorm,
  wind,
}

extension WeatherFunction on Weathertypes {
  String getDescription() {
    switch (this) {
      case Weathertypes.sunny:
        return 'The weather is bright and sunny!';
      case Weathertypes.cloudy:
        return 'It is cloudy with a chance of gloom.';
      case Weathertypes.rain:
        return 'It is raining, bring an umbrella!';
      case Weathertypes.snow:
        return 'Snow is falling, it\'s going to be chilly!';
      case Weathertypes.fog:
        return 'It\'s foggy, visibility might be low!';
      case Weathertypes.thunderstorm:
        return 'Thunderstorm! Stay safe indoors!';
      case Weathertypes.wind:
        return 'It\'s quite windy outside!';
      default:
        return 'The weather is unpredictable!';
    }
  }

  IconData getIcon() {
    switch (this) {
      case Weathertypes.sunny:
        return Icons.wb_sunny;
      case Weathertypes.cloudy:
        return Icons.cloud;
      case Weathertypes.rain:
        return Icons.umbrella;
      case Weathertypes.snow:
        return Icons.ac_unit;
      case Weathertypes.fog:
        return Icons.foggy;
      case Weathertypes.thunderstorm:
        return Icons.thunderstorm;
      case Weathertypes.wind:
        return Icons.air;
      default:
        return Icons.help_outline; // Default icon
    }
  }

  Color getBackgroundColor() {
    switch (this) {
      case Weathertypes.sunny:
        return Colors.yellow.shade300;
      case Weathertypes.cloudy:
        return Colors.grey.shade600;
      case Weathertypes.rain:
        return Colors.blue.shade400;
      case Weathertypes.snow:
        return Colors.lightBlue.shade100;
      case Weathertypes.fog:
        return Colors.grey.shade400;
      case Weathertypes.thunderstorm:
        return Colors.deepPurple.shade700;
      case Weathertypes.wind:
        return Colors.teal.shade200;
      default:
        return Colors.blueGrey; // Default color
    }
  }
}
