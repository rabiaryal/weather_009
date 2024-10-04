import 'package:flutter/material.dart';
import 'package:weather_009/pages/widgets/weathertypes.dart';

class DisplayWeatherTypes extends StatelessWidget {
  DisplayWeatherTypes({super.key});

  Weathertypes currentWeather = Weathertypes.rain;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(currentWeather.getDescription()),
          
        
        ],
      ),
      
      );
    
  }
}
