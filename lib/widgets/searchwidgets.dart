import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:weather_009/repository/fetchcountry.dart'; // Assuming this is where you get countries

class CountrySearchBox extends StatefulWidget {
  @override
  _CountrySearchBoxState createState() => _CountrySearchBoxState();
}

class _CountrySearchBoxState extends State<CountrySearchBox> {
  List<String> countries = [];
  String? selectedCountry;
  final CountryService countryService = CountryService();

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  Future<void> loadCountries() async {
    try {
      List<String> fetchedCountries = await countryService.fetchCountries();
      setState(() {
        countries = fetchedCountries;
      });
    } catch (e) {
      print('Error loading countries: $e');
    }
  }

  // This function fetches countries asynchronously and filters them
  Future<List<String>> fetchCountries(String filter) async {
    return countries
        .where((country) =>
            country.toLowerCase().contains(filter.toLowerCase())) // Filter countries based on search
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DropdownSearch<String>(
            popupProps: const PopupProps.dialog(
              showSearchBox: true, // Enables the search bar
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Search country", // Placeholder text in search bar
                ),
              ),
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Select a country",
                hintText: "Choose a country",
              ),
            ),
            asyncItems: (String? filter) => fetchCountries(filter ?? ''),
            onChanged: (String? newValue) {
              setState(() {
                selectedCountry = newValue;
              });
              print('You selected $newValue');
            },
            selectedItem: selectedCountry,
          ),
          const SizedBox(height: 20),
          if (selectedCountry != null)
            Text('Selected Country: $selectedCountry'),
        ],
      ),
    );
  }
}
