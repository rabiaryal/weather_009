import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:weather_009/bloc/weather_bloc.dart'; // Ensure WeatherBloc is imported
import 'package:weather_009/pages/firstpage.dart';
import 'package:weather_009/res/extensions/enums.dart';
import 'package:weather_009/models/citymodel.dart'; // Ensure City model is imported
// Import FirstPage where you want to pass data

class CitySearchBox extends StatefulWidget {
  const CitySearchBox({super.key});

  @override
  _CitySearchBoxState createState() => _CitySearchBoxState();
}

class _CitySearchBoxState extends State<CitySearchBox> {
  City? selectedCity; // Selected city object

  @override
  void initState() {
    super.initState();
    // Trigger fetching city list as soon as the widget is loaded
    context.read<WeatherBloc>().add(FetchCityEvent(query: 'mumbai'));  // Test with a valid city name
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20),
        child: Column(
          children: [
            BlocBuilder<WeatherBloc, WeatherStates>(
              builder: (context, state) {
                print("State: ${state.postApiStatus}"); // Print the state
                if (state.postApiStatus == PostApiStatus.loading) {
                  return const CircularProgressIndicator(); // Loading indicator
                } else if (state.postApiStatus == PostApiStatus.success &&
                    state.cities != null) {
                  print("Cities: ${state.cities}");  // Print cities to debug
                  return Expanded(
                    child: SearchableList<City>(
                      initialList: state.cities!, // List of cities from the API
                      itemBuilder: (city) => ListTile(
                        title: Text(city.name ?? 'Unknown City'), 
                        subtitle: Text(city.country ?? 'Unknown Country'),
                        onTap: () {
                          setState(() {
                            selectedCity = city; // Update selected city
                          });
                          print(
                              'Selected City: ${city.name}, Country: ${city.country}');

                          // Navigate to FirstPage with city details
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => FirstPage(
                          //       selectedCity: city.name ?? 'Unknown',
                          //       latitude: city.latitude ?? 0.0, // Pass latitude
                          //       longitude: city.longitude ?? 0.0, // Pass longitude
                          //     ),
                          //   ),
                          // );

                          context.read<WeatherBloc>().add(
                                SelectCityEvent(selectedCity: city),
                              ); // Dispatch the selected city event
                        },
                      ),
                      filter: (value) => state.cities!
                          .where((city) =>
                              city.name
                                  ?.toLowerCase()
                                  .contains(value.toLowerCase()) ?? false)
                          .toList(),
                      emptyWidget: const Center(
                        child: Text('No city found'),
                      ),
                    ),
                  );
                } else {
                  return const Text('Error loading cities');
                }
              },
            ),
            const SizedBox(height: 20),
            if (selectedCity != null)
              Text(
                'Selected City: ${selectedCity!.name}, ${selectedCity!.country}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
