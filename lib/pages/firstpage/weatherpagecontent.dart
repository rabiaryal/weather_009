import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_009/bloc/weather_bloc.dart';
import 'package:weather_009/pages/firstpage/backgroundwidgets.dart';
import 'package:weather_009/pages/firstpage/popUpbutton.dart';
import 'package:weather_009/pages/widgets/datewidgets.dart';
import 'package:weather_009/pages/widgets/displayweather.dart';
import 'package:weather_009/pages/widgets/locationwidget.dart';
import 'package:weather_009/pages/widgets/tempreature.dart';
import 'package:weather_009/pages/widgets/weathertypes.dart';


class WeatherPageContent extends StatelessWidget {
  final WeatherStates state;

  const WeatherPageContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final weather = state.weatherDetails!;
    final temperature = weather.temp;
    final utcTime = weather.utcTime;
    final timezoneOffset = weather.timezoneOffset;

    // Access selected city and country from state
    final String cityName = state.selectedCity ?? 'Unknown City';
    final String countryName = state.selectedCountry?.countryname ?? 'Unknown Country';

    Weathertypes currentWeather = weather.weatherType;
    final DateTime utcDateTime = DateTime.fromMillisecondsSinceEpoch(utcTime * 1000, isUtc: true);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<WeatherBloc>().add(RefreshWeatherEvent());
        },
        child: Stack(
          children: [
            const BackgroundWidget(),
            SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PopupButton(),
                      const SizedBox(height: 5),
                      LocationWidgets(cityName: cityName, countryName: countryName),
                      const SizedBox(height: 10),
                      DateWidgets(utcTime: utcDateTime, timezoneOffset: timezoneOffset),
                      const SizedBox(height: 10),
                      TemperatureWidgets(temperature: temperature),
                      const SizedBox(height: 10),
                      Descriptionweathers(weatherType: currentWeather),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





// class WeatherPageContent extends StatelessWidget {
//   final WeatherStates state;

//   const WeatherPageContent({super.key, required this.state});

//   @override
//   Widget build(BuildContext context) {
//     final weather = state.weatherDetails!;
//     final temperature = weather.temp;
//     final country = state.selectedCountry?.countryname ?? 'Unknown Country';
//     final city = state.selectedCity ?? 'Unknown City';
//     final utcTime = weather.utcTime;
//     final timezoneOffset = weather.timezoneOffset;

//     Weathertypes currentWeather = weather.weatherType;

//     final DateTime utcDateTime = DateTime.fromMillisecondsSinceEpoch(utcTime * 1000, isUtc: true);

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       body: RefreshIndicator(
//         onRefresh: () async {
//           context.read<WeatherBloc>().add(RefreshWeatherEvent());
//         },
//         child: Stack(
//           children: [
//             const BackgroundWidget(),
//             SafeArea(
//               child: SingleChildScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const PopupButton(),
//                       const SizedBox(height: 5),
//                       LocationWidgets(cityName: city, countryName: country),
//                       const SizedBox(height: 10),
//                       DateWidgets(utcTime: utcDateTime, timezoneOffset: timezoneOffset),
//                       const SizedBox(height: 10),
//                       TemperatureWidgets(temperature: temperature),
//                       const SizedBox(height: 10),
//                       Descriptionweathers(weatherType: currentWeather),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
