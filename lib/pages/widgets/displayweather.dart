import 'package:flutter/material.dart';
import 'package:weather_009/pages/widgets/weathertypes.dart';

class DisplayWeatherTypes extends StatelessWidget {
  const DisplayWeatherTypes({Key? key, required this.weatherType})
      : super(key: key);

  final Weathertypes weatherType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            weatherType.getIcon(), // Get the icon based on the weather type
            size: 40,
            color: Colors.black,
          ),
          const SizedBox(width: 10), // Space between icon and text
          Flexible(
            child: Text(
              weatherType.getDescription(), // Get the description based on the weather type
              style: const TextStyle(fontSize: 16),
              maxLines: 2, // Maximum number of lines the text can take
              overflow: TextOverflow.ellipsis, // Shows "..." if it overflows
              softWrap: true, // Enable wrapping
            ),
          ),
        ],
      ),
    );
  }
}
