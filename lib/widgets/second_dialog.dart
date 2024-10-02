import 'package:flutter/material.dart';
import 'package:weather_009/widgets/first_widgets.dart';

class SecondDialog {
  TextEditingController latController = TextEditingController();
  TextEditingController lonController = TextEditingController();

  void showDialogAlertBox(BuildContext context, Function(String, String) onSave) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter Info"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WidgetsCollection1().textFormField(latController, 'Latitude'),
              const SizedBox(height: 15),
              WidgetsCollection1().textFormField(lonController, 'Longitude'),
            ],
          ),
          actions: [
            WidgetsCollection1().roundButton(context, 'Save', 'get', () {
              // Call the callback function to pass data back to Homepages
              onSave(latController.text, lonController.text);
              Navigator.of(context).pop();
            }),
            WidgetsCollection1().roundButton(context, 'Cancel', 'cancel', () {
              Navigator.of(context).pop();
            }),
          ],
        );
      },
    );
  }
}
