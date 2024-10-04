import 'package:flutter/material.dart';
import 'package:weather_009/pages/widgets/datewidgets.dart';
import 'package:weather_009/pages/widgets/locationwidget.dart';
import 'package:weather_009/pages/widgets/popupbutton.dart';
import 'package:weather_009/pages/widgets/tempreature.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                showPopupMenu(context);
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage('assets/images/navyblue background.jpg'),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80), // Added spacing below AppBar
                    LocationWidgets(),
                    SizedBox(
                      height: 5,
                    ),
                    DateWidgets(),
                    SizedBox(height: 5,),
                    TempreatureWidgets(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
