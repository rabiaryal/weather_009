import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_009/bloc/weather_bloc.dart';
import 'package:weather_009/route/route_name.dart';

import 'package:weather_009/widgets/dialog.dart';


enum Menu { add, temperature, frequency, theme, dialog }

void showPopupMenu(BuildContext context) async {
  final screenSize = MediaQuery.of(context).size;
  const double padding = 22.0;

  final Menu? selected = await showMenu<Menu>(
    context: context,
    position: RelativeRect.fromLTRB(
      screenSize.width - padding,
      padding,
      0,
      0,
    ),
    items: [
      const PopupMenuItem<Menu>(
        value: Menu.add,
        child: ListTile(
          leading: Icon(Icons.add_location),
          title: Text('Add Country'),
        ),
      ),
      const PopupMenuItem<Menu>(
        value: Menu.dialog,
        child: ListTile(
          leading: Icon(Icons.add),
          title: Text('Add Cities'),
        ),
      ),
      const PopupMenuItem<Menu>(
        value: Menu.temperature,
        child: ListTile(
          leading: Icon(Icons.thermostat),
          title: Text('Temperature Units'),
        ),
      ),
      const PopupMenuItem<Menu>(
        value: Menu.frequency,
        child: ListTile(
          leading: Icon(Icons.sync),
          title: Text('Update Frequency'),
        ),
      ),
      const PopupMenuItem<Menu>(
        value: Menu.theme,
        child: ListTile(
          leading: Icon(Icons.nightlight_round),
          title: Text('Theme'),
        ),
      ),
    ],
  );

  if (selected == Menu.add) {

    Navigator.pushNamed(context, RouteName.searchcountry);

      //   Navigator.push(
      // context,
      // MaterialPageRoute(
      //   builder: (context) => const CitySearchBox(), // Navigate to the CitySearchBox
      // ),

        
    
  } else if (selected == Menu.dialog) {
    // Show dialog to add a city
    showSecondDialog(context, (cityName) {
      if (cityName.isNotEmpty) {
        context.read<WeatherBloc>().add(SelectCityEvent(cityName: cityName));
      }
    });
  }
}

// Define the addCountry function to collect countryname, latitude, longitude, and flagUrl
