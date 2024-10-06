import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_009/extensions/enums.dart';
import 'package:weather_009/models/citymodel.dart';
import 'package:weather_009/pages/widgets/datewidgets.dart';
import 'package:weather_009/pages/widgets/displayweather.dart';
import 'package:weather_009/pages/widgets/locationwidget.dart';
import 'package:weather_009/pages/widgets/popupbutton.dart';
import 'package:weather_009/pages/widgets/tempreature.dart';
import 'package:weather_009/pages/widgets/weathertypes.dart';
import 'package:weather_009/bloc/weather_bloc.dart';

class FirstPage extends StatefulWidget {
  final City selectedCity;

  const FirstPage({Key? key, required this.selectedCity}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Weathertypes currentWeather = Weathertypes.snow;

  @override
  void initState() {
    super.initState();
    // Dispatch an event to fetch the weather details when the widget is initialized
    context
        .read<WeatherBloc>()
        .add(FetchWeatherEvent(selectedCity: widget.selectedCity));
    // context.read<WeatherBloc>().add(FetchCityEvent(query: "Kathmandu"));// Ensure correct event is used
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
          final city = widget.selectedCity.name;
          final country = widget.selectedCity.country;

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
                          // Display selected location
                          LocationWidgets(city: city, countryName: country),
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
