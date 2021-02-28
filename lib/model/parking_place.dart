import 'package:google_maps_flutter/google_maps_flutter.dart';

//Latitude & Longitude
//Name
//Description
//Ranking (1-5 stars)
class ParkingPlace {
  final LatLng location;
  final String name;
  final String description;
  final int rating;

  ParkingPlace(
    this.location,
    this.name,
    this.description,
    this.rating,
  );
}
