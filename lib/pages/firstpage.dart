import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_009/models/citymodel.dart';
import 'package:weather_009/models/countrymodel.dart';
import 'package:weather_009/pages/widgets/datewidgets.dart';
import 'package:weather_009/pages/widgets/displayweather.dart';
import 'package:weather_009/pages/widgets/locationwidget.dart';
import 'package:weather_009/pages/widgets/popupbutton.dart';
import 'package:weather_009/pages/widgets/tempreature.dart';
import 'package:weather_009/pages/widgets/weathertypes.dart';
import 'package:weather_009/bloc/weather_bloc.dart';
import 'package:weather_009/res/extensions/enums.dart';

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
    // Fetch weather for the selected country
    _fetchWeatherForSelectedCountry(context);
  }

 void _fetchWeatherForSelectedCountry(BuildContext context) async {
  // Get the selected country from the WeatherBloc state
  final selectedCountry = context.read<WeatherBloc>().state.selectedCountry;

  if (selectedCountry != null) {
    // Dispatch an event to select the country
    context.read<WeatherBloc>().add(SelectCountryEvent(selectedCountry: selectedCountry));

    // After selecting the country, the weather fetching will be handled in the bloc
  } else {
    print("No country selected.");
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

          final country =
              state.selectedCountry?.countryname ?? 'Unknown Country';

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
                          LocationWidgets(
                              city: "Not Required", countryName: country),
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
        } else {
          return const Center(child: Text('No data available.'));
        }
      },
    );
  }
}
