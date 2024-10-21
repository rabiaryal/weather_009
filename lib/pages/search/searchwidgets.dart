import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:weather_009/bloc/weather_bloc.dart';
import 'package:weather_009/models/countrymodel.dart'; // Ensure you have a country model imported
import 'package:weather_009/res/extensions/enums.dart';

class CitySearchBox extends StatefulWidget {
  const CitySearchBox({super.key});

  @override
  _CitySearchBoxState createState() => _CitySearchBoxState();
}

class _CitySearchBoxState extends State<CitySearchBox> {
  @override
  void initState() {
    super.initState();
    // Trigger fetching the country list as soon as the widget is loaded
    context.read<WeatherBloc>().add(const FetchCountryEvent()); // Fetch list of countries
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Country')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: BlocBuilder<WeatherBloc, WeatherStates>(
          builder: (context, state) {
            print("State: ${state.postApiStatus}"); // Print the state
            if (state.postApiStatus == PostApiStatus.loading) {
              return const CircularProgressIndicator(); // Show loading indicator
            } else if (state.postApiStatus == PostApiStatus.success && state.countries != null) {
              // Display list of countries
              return Expanded(
                child: SearchableList<Country>(
                  initialList: state.countries!,
                  itemBuilder: (country) => ListTile(
                    title: Text(country.countryname ?? 'Unknown Country'),
                    onTap: () {
                      print('Selected Country: ${country.countryname}');
                      // Dispatch the selected country event and pass it back to the first page
                      context.read<WeatherBloc>().add(SelectCountryEvent(selectedCountry: country));
                      Navigator.pop(context); // Pop the current screen to go back
                    },
                  ),
                  filter: (value) => state.countries!
                      .where((country) => country.countryname.toLowerCase().contains(value.toLowerCase()) ?? false)
                      .toList(),
                  emptyWidget: const Center(child: Text('No country found')),
                ),
              );
            } else {
              return const Text('Error loading countries');
            }
          },
        ),
      ),
    );
  }
}
