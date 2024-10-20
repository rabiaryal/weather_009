import 'package:flutter/material.dart';
import 'package:weather_009/models/citymodel.dart';
import 'package:weather_009/repository/fetchcitylist.dart';


class CityDropdown extends StatefulWidget {
  @override
  _CityDropdownState createState() => _CityDropdownState();
}

class _CityDropdownState extends State<CityDropdown> {
  City? selectedCity; // Store the selected City object instead of String
  List<City> cityList = [];
  final FetchCity fetchCity = FetchCity();

  Future<void> searchAndUpdateCities(String query) async {
    if (query.isNotEmpty) {
      try {
        List<City> cities = await fetchCity.fetchCitiesWithWeather(query);

        setState(() {
          cityList = cities;
          selectedCity = cities.isNotEmpty ? cities[0] : null;
        });
      } catch (e) {
        print('Error fetching cities: $e');
        setState(() {
          cityList = [];
        });
      }
    } else {
      setState(() {
        cityList = [];
        selectedCity = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) => searchAndUpdateCities(query),
              decoration: const InputDecoration(
                labelText: "Search City",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            cityList.isNotEmpty
                ? DropdownButton<City>(
                    value: selectedCity,
                    hint: const Text("Select a City"),
                    isExpanded: true,
                    items: cityList.map<DropdownMenuItem<City>>((City city) {
                      return DropdownMenuItem<City>(
                        value: city,
                        child: Text('${city.name}, ${city.country}'),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedCity = newValue;
                      });
                    },
                  )
                : const Text("No cities found. Please search."),
            const SizedBox(height: 20),
            selectedCity != null
                ? ElevatedButton(
                    onPressed: () {
                      print(
                          'Selected City: ${selectedCity!.name}, Country: ${selectedCity!.country}');

                      // // Navigate to the WeatherScreen and pass latitude & longitude
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => WeatherScreen(
                      //       city: selectedCity!,
                      //     ),
                      //   ),
                      // );
                    },
                    child: const Text("Fetch Weather"),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
