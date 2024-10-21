import 'package:flutter/material.dart';
import 'package:weather_009/pages/widgets/popupbutton.dart';

class PopupButton extends StatelessWidget {
  const PopupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            showPopupMenu(context);
          },
          icon: const Icon(Icons.more_vert, color: Colors.black),
        ),
      ],
    );
  }
}
