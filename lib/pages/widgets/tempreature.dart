import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class TempreatureWidgets extends StatelessWidget {
  const TempreatureWidgets({super.key});

  Widget getTemperature() {
    return Math.tex(
      r'25 \degree \text{C}', // Display temperature with degree symbol and Celsius
      textStyle: TextStyle(fontSize: 100), // Base font size for the temperature
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width:300,
      child: getTemperature(),
      // color: Colors.green,?
    );
  }
}
