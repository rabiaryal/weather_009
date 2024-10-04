import 'package:flutter/material.dart';
import 'package:weather_009/models/citymodel.dart';
import 'package:weather_009/repository/fetchcitylist.dart';
import 'package:weather_009/repository/weather_repository.dart';

class CitySearch extends StatefulWidget {
  final Function(double) onCitySelected; // Accept the callback

  const CitySearch({Key? key, required this.onCitySelected}) : super(key: key);
  
  @override
  _CitySearchState createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  List<City> cities = [];
  bool isLoading = false;
  final WeatherRepository weatherRepository = WeatherRepository();
  final FetchCity fetchCity = FetchCity();

  void searchCities(String query) async {
    setState(() {
      isLoading = true;
      cities = []; // Clear previous results
    });

    try {
      // Fetch cities using the query
      List<City> fetchedCities = await fetchCity.fetchCities(query);
      setState(() {
        cities = fetchedCities; // Update the city list with fetched cities
      });
    } catch (e) {
      print('Error fetching cities: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void selectCity(City city) async {
    try {
      // Fetch weather data for the selected city
      var weather = await weatherRepository.fetchWeathers(city.latitude, city.longitude);
      widget.onCitySelected(weather.main?.temp ?? 0); // Call the passed callback with the temperature

      Navigator.pop(context); // Close the search screen
    } catch (e) {
      print('Error selecting city: $e');
    }
  }
  void onCitySelected(City city) async {
  try {
    // Fetch weather data for the selected city
    var weather = await weatherRepository.fetchWeathers(city.latitude, city.longitude);
    
    // Call the passed callback with both the temperature and the city object
    widget.onCitySelected(weather.main?.temp, city);

    Navigator.pop(context); // Close the search screen
  } catch (e) {
    print('Error selecting city: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Cities'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              onSubmitted: searchCities,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(), // Show loading spinner
            if (!isLoading && cities.isEmpty) const Text("No cities found"), // Message if no cities found
            Expanded(
              child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${cities[index].name}, ${cities[index].country}'),
                    onTap: () => selectCity(cities[index]), // Call selectCity when a city is tapped
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
