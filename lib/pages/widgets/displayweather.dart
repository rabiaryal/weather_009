import 'package:flutter/material.dart';
import 'package:weather_009/pages/widgets/weathertypes.dart';

class Descriptionweathers extends StatelessWidget {
  const Descriptionweathers({super.key, required this.weatherType});

  final Weathertypes weatherType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        
        color:

        
         weatherType.getBackgroundColor(), // Use the new background color method
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            weatherType.getIcon(), // Use the new getIcon method
            size: 40,
            color: Colors.black,
          ),
          const SizedBox(width: 10), // Space between icon and text
          Flexible(
            child: Text(
              weatherType.getDescription(), // Use the new getDescription method
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
