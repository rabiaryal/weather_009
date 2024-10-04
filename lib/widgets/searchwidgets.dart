import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:weather_009/bloc/weather_bloc.dart';
import 'package:weather_009/extensions/enums.dart'; // Make sure the WeatherBloc is imported

class CountrySearchBox extends StatefulWidget {
  const CountrySearchBox({super.key});

  @override
  _CountrySearchBoxState createState() => _CountrySearchBoxState();
}

class _CountrySearchBoxState extends State<CountrySearchBox> {
  String? selectedCountry;

  @override
  void initState() {
    super.initState();
   context.read<WeatherBloc>().add(const FetchCountries());

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
              } else if (state.postApiStatus == PostApiStatus.success &&
                  state.countries != null) {
                return DropdownSearch<String>(
                  items: state.countries!.map((e) => e.countryname).toList(),
                  popupProps: const PopupProps.dialog(
                    showSearchBox: true, // Enables the search bar
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        labelText:
                            "Search country", // Placeholder text in search bar
                      ),
                    ),
                  ),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Select a country",
                      hintText: "Choose a country",
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCountry = newValue;
                    });

                    // Dispatch an event to handle the selected country
                    context.read<WeatherBloc>().add(
                          SelectCountry(
                            selectedCountry: state.countries!.firstWhere(
                                (country) => country.countryname == newValue),
                          ),
                        );
                  },
                  selectedItem: selectedCountry,
                );
              } else {
                return const Text('Error loading countries');
              }
            },
          ),
          const SizedBox(height: 20),
          if (selectedCountry != null)
            Text('Selected Country: $selectedCountry'),
        ],
      ),
    );
  }
}
