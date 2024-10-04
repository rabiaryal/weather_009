import 'package:flutter/material.dart';
import 'package:weather_009/pages/search/search.dart'; // Ensure this import is correct

enum Menu { add, temperature, frequency, theme }

void showPopupMenu(BuildContext context, Function(double) onCitySelected) async {
  final screenSize = MediaQuery.of(context).size;
  const double padding = 22.0;

  final Menu? selected = await showMenu<Menu>(
    context: context,
    position: RelativeRect.fromLTRB(
      screenSize.width - padding, // Right position with padding
      padding, // Top position with padding
      0, // Left position
      0, // Bottom position
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

  // Handle menu selection
  if (selected == Menu.add) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CitySearch(onCitySelected: onCitySelected), // Pass the callback here
      ),
    );
  }
  // You can add additional logic for other menu items here if needed
}
