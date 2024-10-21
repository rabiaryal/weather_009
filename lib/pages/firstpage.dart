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
  Weathertypes currentWeather = Weathertypes.snow;

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
    Country selectedCountry = await context.read<WeatherBloc>().countryService.fetchCountryByLatLong(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    // Dispatch the FetchWeatherEvent with the selected country
    context.read<WeatherBloc>().add(FetchWeatherEvent(selectedCountry: selectedCountry));

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
        } else if (state.postApiStatus == PostApiStatus.success &&
            state.weatherDetails != null) {
          final weather = state.weatherDetails!;
          final temperature = weather.temp;
          final country = state.selectedCountry?.countryname ?? 'Unknown Country';

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Scaffold(
              extendBodyBehindAppBar: true,
              body: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: currentWeather.getBackgroundColor(),
                  ),
                  SafeArea(
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
                                icon: const Icon(Icons.more_vert,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          LocationWidgets(city: "Not Required", countryName: country),
                          const SizedBox(height: 10),
                          const DateWidgets(),
                          const SizedBox(height: 10),
                          TemperatureWidgets(temperature: temperature),
                          const SizedBox(height: 10),
                          Descriptionweathers(weatherType: currentWeather),
                        ],
                      ),
                    ),
                  ),
                ],
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
