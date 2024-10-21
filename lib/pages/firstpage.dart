import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_009/models/countrymodel.dart';
import 'package:weather_009/pages/widgets/datewidgets.dart';
import 'package:weather_009/pages/widgets/displayweather.dart';
import 'package:weather_009/pages/widgets/locationwidget.dart';
import 'package:weather_009/pages/widgets/popupbutton.dart';
import 'package:weather_009/pages/widgets/tempreature.dart';
import 'package:weather_009/pages/widgets/weathertypes.dart';
import 'package:weather_009/bloc/weather_bloc.dart';
import 'package:weather_009/res/extensions/enums.dart';
import 'package:weather_009/utils/func/geolocator.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Weathertypes currentWeather = Weathertypes.cloudy;

  @override
  void initState() {
    super.initState();
    _fetchInitialLocationAndWeather();
  }

  Future<void> _fetchInitialLocationAndWeather() async {
    try {
      // Get the user's current position
      Position position = await determinePosition();

      // Fetch the closest country using latitude and longitude
      Country selectedCountry = await context
          .read<WeatherBloc>()
          .countryService
          .fetchCountryByLatLong(
            latitude: position.latitude,
            longitude: position.longitude,
          );

      // Dispatch the FetchWeatherEvent with the selected country
      context
          .read<WeatherBloc>()
          .add(FetchWeatherEvent(selectedCountry: selectedCountry));
    } catch (e) {
      print('Error fetching location or country: $e');
      // Handle error appropriately, e.g., show a dialog or message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherStates>(
      builder: (context, state) {
        if (state.postApiStatus == PostApiStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.postApiStatus == PostApiStatus.success && state.weatherDetails != null) {
          final weather = state.weatherDetails!;
          final temperature = weather.temp;
          final country = state.selectedCountry?.countryname ?? 'Unknown Country';
          final utcTime = weather.utcTime; 
          final timezoneOffset = weather.timezoneOffset; 

          // Update the currentWeather type based on the fetched weather details
          currentWeather = weather.weatherType;

          final DateTime utcDateTime = DateTime.fromMillisecondsSinceEpoch(
              utcTime * 1000,
              isUtc: true);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Scaffold(
              extendBodyBehindAppBar: true,
              body: RefreshIndicator(
                onRefresh: () async {
                  // Trigger the refresh event
                  context.read<WeatherBloc>().add(RefreshWeatherEvent());
                },
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.blue.shade100,
                      
                      // currentWeather.getBackgroundColor(), // Set background color dynamically
                    ),
                    SafeArea(
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(), // Ensure scrolling always works
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showPopupMenu(context);
                                    },
                                    icon: const Icon(Icons.more_vert, color: Colors.black),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              LocationWidgets(countryName: country),
                              const SizedBox(height: 10),
                              DateWidgets(
                                utcTime: utcDateTime, // Pass UTC time
                                timezoneOffset: timezoneOffset, // Pass timezone offset
                              ),
                              const SizedBox(height: 10),
                              TemperatureWidgets(temperature: temperature),
                              const SizedBox(height: 10),
                              Descriptionweathers(weatherType: currentWeather), // Update description dynamically
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state.postApiStatus == PostApiStatus.error) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else {
          return const Center(child: Text('No data available.'));
        }
      },
    );
  }
}



// Widget build(BuildContext context) {
//     return BlocBuilder<WeatherBloc, WeatherStates>(
//       builder: (context, state) {
//         if (state.postApiStatus == PostApiStatus.loading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state.postApiStatus == PostApiStatus.success &&
//             state.weatherDetails != null) {
//           final weather = state.weatherDetails!;
//           final temperature = weather.temp;
//           final country =
//               state.selectedCountry?.countryname ?? 'Unknown Country';

//           final utcTime =
//               weather.utcTime; // Ensure you have the correct property name
//           final timezoneOffset = weather.timezoneOffset;
//           final DateTime utcDateTime = DateTime.fromMillisecondsSinceEpoch(
//               utcTime * 1000,
//               isUtc: true); // Ensure you have the correct property name

//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData(
//               primarySwatch: Colors.blue,
//             ),
//             home: Scaffold(
//               extendBodyBehindAppBar: true,
//               body: RefreshIndicator(
//                 onRefresh: () async {
//                   context.read<WeatherBloc>().add(RefreshWeatherEvent());
//                 },
//                 child: Stack(
//                   children: [
//                     Container(
//                       height: double.infinity,
//                       width: double.infinity,
//                       color: currentWeather.getBackgroundColor(),
//                     ),
//                     SafeArea(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 IconButton(
//                                   onPressed: () {
//                                     showPopupMenu(context);
//                                   },
//                                   icon: const Icon(Icons.more_vert,
//                                       color: Colors.black),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 5),
//                             LocationWidgets(countryName: country),
//                             const SizedBox(height: 10),
//                             DateWidgets(
//                               utcTime: utcDateTime,
//                               // Pass UTC time
//                               timezoneOffset:
//                                   timezoneOffset, // Pass timezone offset
//                             ),
//                             const SizedBox(height: 10),
//                             TemperatureWidgets(temperature: temperature),
//                             const SizedBox(height: 10),
//                             Descriptionweathers(weatherType: currentWeather),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         } else if (state.postApiStatus == PostApiStatus.error) {
//           return Center(child: Text('Error: ${state.errorMessage}'));
//         } else {
//           return const Center(child: Text('No data available.'));
//         }
//       },
//     );
//   }

