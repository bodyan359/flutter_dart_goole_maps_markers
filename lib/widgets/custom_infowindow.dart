import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dart_goole_maps_markers/model/infowindow.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../model/parking_place.dart';

class CustomInfoWindow extends StatefulWidget {
  @override
  _CustomInfoWindowState createState() => _CustomInfoWindowState();
}

class _CustomInfoWindowState extends State<CustomInfoWindow> {
  GoogleMapController mapController;
  Set<Marker> _markers = Set<Marker>();

  final LatLng _center = LatLng(37.427961, -122.085750);
  final double _zoom = 16.0;

  Map<String, ParkingPlace> _parkingPlaceList = {
    // TODO: add new markers here from add_parking_place_screen
    "Place1": ParkingPlace(
        LatLng(37.429175, -122.083951), 'Place1', 'Place for maximum chill', 5),
    "Place2": ParkingPlace(
        LatLng(37.427961, -122.085750), 'Place2', 'Place with lovely', 3),
  };

  final double _infoWindowWidth = 250;
  final double _markerOffset = 150;

  @override
  Widget build(BuildContext context) {
    final providerObject = Provider.of<InfoWindowModel>(context, listen: false);
    _parkingPlaceList.forEach((key, value) {
      _markers.add(Marker(
        markerId: MarkerId(value.location.toString()),
        position: value.location,
        onTap: () {
          providerObject.updateInfoWindow(
            context,
            mapController,
            value.location,
            _infoWindowWidth,
            _markerOffset,
          );
          providerObject.updateParkingPlaces(value);
          providerObject.updateVisibility(true);
          providerObject.rebuildInfoWindow();
        },
      ));
    });
    return Scaffold(
      body: Container(
        child: Consumer<InfoWindowModel>(
          builder: (context, model, child) {
            return Stack(
              children: [
                child,
                Positioned(
                  left: 0,
                  top: 0,
                  child: Visibility(
                    visible: providerObject.showInfoWindow,
                    child: (providerObject.parkingPlace == null ||
                            !providerObject.showInfoWindow)
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(
                                left: providerObject.leftMargin,
                                top: providerObject.topMargin),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.white54,
                                          Colors.white60,
                                        ],
                                        end: Alignment.bottomCenter,
                                        begin: Alignment.topCenter),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.blueGrey,
                                          offset: Offset(0.0, 1.0),
                                          blurRadius: 1.0),
                                    ],
                                  ),
                                  height: 100,
                                  // width: 250,
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            providerObject.parkingPlace.location
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            providerObject.parkingPlace.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            providerObject
                                                .parkingPlace.description,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconTheme(
                                            data: IconThemeData(
                                              color: Colors.orange,
                                              size: 18,
                                            ),
                                            child: Row(
                                              children:
                                                  List.generate(5, (index) {
                                                return Icon(
                                                  index <
                                                          providerObject
                                                              .parkingPlace
                                                              .rating
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Triangle.isosceles(
                                  edge: Edge.BOTTOM,
                                  child: Container(
                                    color: Colors.blueGrey,
                                    width: 20.0,
                                    height: 15.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            );
          },
          child: Positioned(
            child: GoogleMap(
              markers: _markers,
              onTap: (position) {
                if (providerObject.showInfoWindow) {
                  providerObject.updateVisibility(false);
                  providerObject.rebuildInfoWindow();
                }
              },
              onCameraMove: (position) {
                if (providerObject.parkingPlace != null) {
                  providerObject.updateInfoWindow(
                    context,
                    mapController,
                    providerObject.parkingPlace.location,
                    _infoWindowWidth,
                    _markerOffset,
                  );
                  providerObject.rebuildInfoWindow();
                }
              },
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition:
                  CameraPosition(target: _center, zoom: _zoom),
            ),
          ),
        ),
      ),
    );
  }
}
