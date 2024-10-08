import 'package:flutter/material.dart';
import 'package:weather_009/pages/search/search.dart';
import 'package:weather_009/widgets/searchwidgets.dart';

enum Menu { add, temperature, frequency, theme }

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CitySearchBox(), // Navigate to the CitySearchBox
      ),
    );
  }
}
