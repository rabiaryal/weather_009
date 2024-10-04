import 'package:flutter/material.dart';
import 'package:weather_009/pages/widgets/datewidgets.dart';
import 'package:weather_009/pages/widgets/displayweather.dart';
import 'package:weather_009/pages/widgets/locationwidget.dart';
import 'package:weather_009/pages/widgets/popupbutton.dart';
import 'package:weather_009/pages/widgets/tempreature.dart';
import 'package:weather_009/pages/widgets/weathertypes.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // Set the initial weather type
  Weathertypes currentWeather = Weathertypes.snow;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        // Remove AppBar from Scaffold
        extendBodyBehindAppBar: true, // Extend the body behind the status bar
        body: Stack(
          children: [
            // Background Color Based on Weather Type
            Container(
              height: double.infinity,
              width: double.infinity,
              color: currentWeather.getBackgroundColor(),
            ),

            // SafeArea widget ensures the UI doesn't overlap with system bars
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Custom AppBar-like Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // IconButton(
                        //   onPressed: () {
                        //     // Functionality for back or menu button
                        //   },
                        //   icon:
                        //       // const Icon(Icons.arrow_back, color: Colors.black),
                        // ),
                        IconButton(
                          onPressed: () {
                            showPopupMenu(context);
                          },
                          icon:
                              const Icon(Icons.more_vert, color: Colors.black),
                        ),
                      ],
                    ),

                    // Body Content starts here
                    const SizedBox(height: 5), // Spacer

                    // Location and Weather Details
                    const LocationWidgets(),
                    const SizedBox(height: 10),
                    const DateWidgets(),
                    const SizedBox(height: 10),
                    const TempreatureWidgets(),
                    const SizedBox(height: 10),
                    DisplayWeatherTypes(weatherType: currentWeather),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
