import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:weather_009/bloc/weather_bloc.dart'; // Ensure WeatherBloc is imported
import 'package:weather_009/models/citymodel.dart'; // Ensure City model is imported

class CitySearchBox extends StatefulWidget {
  const CitySearchBox({super.key});

  @override
  _CitySearchBoxState createState() => _CitySearchBoxState();
}

class _CitySearchBoxState extends State<CitySearchBox> {
  City? selectedCity; // Changed from String? to City?

  @override
  void initState() {
    super.initState();
    // You can initiate a fetch event here if needed
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Use BlocBuilder to listen for WeatherBloc state changes
          BlocBuilder<WeatherBloc, WeatherStates>(
            builder: (context, state) {
              if (state.postApiStatus == PostApiStatus.loading) {
                return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
              } else if (state.postApiStatus == PostApiStatus.success && state.cities != null) {
                return DropdownSearch<City>(
                  items: state.cities, // Assuming this is a list of City objects
                  popupProps: PopupProps.dialog(
                    showSearchBox: true, // Enables the search bar
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        labelText: "Search for a city", // Label for the search field
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Select a city",
                      hintText: "Choose a city",
                    ),
                  ),
                  onChanged: (City? newValue) { // Ensure this is a City type
                    if (newValue != null) {
                      selectedCity = newValue; // Update selectedCity with the selected City object
                      // Pass the selected city object to the event
                      context.read<WeatherBloc>().add(SelectCityEvent(selectedCity: newValue));
                    }
                  },
                  selectedItem: selectedCity, // Show the currently selected city
                );
              } else {
                return const Text('Error loading cities');
              }
            },
          ),
          const SizedBox(height: 20),
          if (selectedCity != null) // Display the selected city's name and country
            Text('Selected City: ${selectedCity.toString()}'),
        ],
      ),
    );
  }
}
