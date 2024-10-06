import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:weather_009/bloc/weather_bloc.dart'; // Ensure WeatherBloc is imported
import 'package:weather_009/extensions/enums.dart';
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20),
        child: Column(
          children: [
            // Use BlocBuilder to listen for WeatherBloc state changes
            
      BlocBuilder<WeatherBloc, WeatherStates>(
  builder: (context, state) {
    if (state.postApiStatus == PostApiStatus.loading) {
      return const CircularProgressIndicator(); // Loading indicator
    } else if (state.postApiStatus == PostApiStatus.success &&
        state.cities != null) {
      return DropdownSearch<City>(
        items: state.cities, // List of cities returned by the API
        popupProps: PopupProps.bottomSheet(
          showSearchBox: true, // Enables search functionality
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              labelText: "Search for a city",
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
        onChanged: (City? newValue) {
          if (newValue != null) {
            setState(() {
              selectedCity = newValue; // Update selected city
            });
            print('Selected City: ${newValue.name}, Country: ${newValue.country}');
            context.read<WeatherBloc>().add(SelectCityEvent(selectedCity: newValue)); // Dispatch the selected city event
          }
        },
        selectedItem: selectedCity, // Display the selected city
      );
    } else {
      return const Text('Error loading cities');
    }
  },
),
      const SizedBox(height: 20),
            if (selectedCity !=
                null) // Display the selected city's name and country
              Text('Selected City: ${selectedCity.toString()}'),
          ],
        ),
      ),
    );
  }
}
