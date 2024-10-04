// this class assign the background color based on the weather here only 
// four types are available

import 'package:flutter/material.dart';
import 'package:weather_009/pages/widgets/weathertypes.dart';

class Assignbackground extends StatelessWidget {
  final Weathertypes weatherType;

  const Assignbackground({Key? key, required this.weatherType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Use the weatherType to set the background color
      color: weatherType.getBackgroundColor(),
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              weatherType.getIcon(),
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              weatherType.getDescription(),
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}