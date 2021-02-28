import 'package:flutter/material.dart';
import 'package:flutter_dart_goole_maps_markers/model/infowindow.dart';
import 'package:flutter_dart_goole_maps_markers/widgets/custom_infowindow.dart';
import 'package:provider/provider.dart';

import 'screens/add_parking_place_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => InfoWindowModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NaviParking',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomInfoWindow(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddParkingPlaceScreen())),
          tooltip: 'Add New Parking Place',
          child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
