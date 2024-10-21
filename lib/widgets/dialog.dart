import 'package:flutter/material.dart';
import 'package:weather_009/widgets/first_widgets.dart';

class SecondDialog extends StatefulWidget {
  const SecondDialog({Key? key}) : super(key: key);

  @override
  _SecondDialogState createState() => _SecondDialogState();
}

class _SecondDialogState extends State<SecondDialog> {
  late TextEditingController cityController;

  @override
  void initState() {
    super.initState();
    cityController = TextEditingController();
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enter City Name"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WidgetsCollection1().textFormField(cityController, 'City Name'),
        ],
      ),
      actions: [
        WidgetsCollection1().roundButton(context, 'Save', 'get', () {
          // Call the callback function to pass data back
          Navigator.of(context).pop(cityController.text);
        }),
        WidgetsCollection1().roundButton(context, 'Cancel', 'cancel', () {
          Navigator.of(context).pop();
        }),
      ],
    );
  }
}

// Function to display the dialog
void showSecondDialog(BuildContext context, Function(String) onSave) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SecondDialog();
    },
  ).then((cityName) {
    if (cityName != null && cityName.isNotEmpty) {
      onSave(cityName); // Pass the city name back to the FirstPage
    }
  });
}
