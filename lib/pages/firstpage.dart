import 'package:flutter/material.dart';
import 'package:weather_009/models/citymodel.dart';
import 'package:weather_009/models/jsonmodels.dart';
import 'package:weather_009/pages/search/search.dart';
import 'package:weather_009/pages/widgets/datewidgets.dart';
import 'package:weather_009/pages/widgets/displayweather.dart';
import 'package:weather_009/pages/widgets/locationwidget.dart';
import 'package:weather_009/pages/widgets/popupbutton.dart';
import 'package:weather_009/pages/widgets/tempreature.dart';
import 'package:weather_009/pages/widgets/weathertypes.dart';
import 'package:weather_009/repository/weather_repository.dart';

class FirstPage extends StatefulWidget {
  City? selectedCity; // Nullable in case no city is passed initially

  FirstPage({Key? key, this.selectedCity}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
 
 Weathertypes currentWeather = Weathertypes.snow;
  WeatherRepository weatherRepository = WeatherRepository();
  double? temperature; // Store the fetched temperature

  @override
  void initState() {
    super.initState();
    if (widget.selectedCity != null) {
      fetchWeatherData(); // Fetch weather data if a city is selected
    }
  }

  Future<void> fetchWeatherData() async {
    if (widget.selectedCity != null) {
      double latitude = widget.selectedCity!.latitude;
      double longitude = widget.selectedCity!.longitude;

      try {
        WeatherModel weatherModel = await weatherRepository.fetchWeathers(latitude, longitude);
        print(weatherModel); // Log the entire weather model to check the structure
        setState(() {
          temperature = weatherModel.main?.temp; // Check if this is the correct path
        });
      } catch (e) {
        print('Error fetching weather data: $e');
      }
    }
  }

  void updateCityAndTemperature(double newTemperature, City city) {
    setState(() {
      temperature = newTemperature; // Update the temperature
      widget.selectedCity = city; // Update the selected city
    });
  }

  void showCitySearch() async {
    final selectedCity = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CitySearch(onCitySelected: updateCityAndTemperature)), // Pass the callback here
    );

    if (selectedCity != null) {
      // Update the state with the selected city
      setState(() {
        widget.selectedCity = selectedCity;
        fetchWeatherData(); // Fetch weather for the newly selected city
      });
    }
  }
  @override
  Widget build(BuildContext context) {
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
                          onPressed:  () {
                          showPopupMenu(context, updateTemperature); // Pass the callback
                        },
                          icon: const Icon(Icons.more_vert, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    if (widget.selectedCity != null)
                      LocationWidgets(
                        city: widget.selectedCity!.name,
                        countryName: widget.selectedCity!.country,
                      ),
                    const SizedBox(height: 10),
                    const DateWidgets(),
                    const SizedBox(height: 10),
                    if (temperature != null) // Check if temperature is fetched
                      TemperatureWidgets(
                        temperature: temperature!, // Pass the fetched temperature
                      ),
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
