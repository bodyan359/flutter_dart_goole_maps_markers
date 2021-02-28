import 'package:flutter/material.dart';
import 'package:flutter_dart_goole_maps_markers/model/parking_place.dart';

class AddParkingPlaceScreen extends StatefulWidget {
  @override
  _AddParkingPlaceScreenState createState() => _AddParkingPlaceScreenState();
}

class _AddParkingPlaceScreenState extends State<AddParkingPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Parking Place"),
        ),
        body: Column(
          children: [],
        ));
  }
}
