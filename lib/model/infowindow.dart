import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dart_goole_maps_markers/model/parking_place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InfoWindowModel extends ChangeNotifier {
  bool _showInfowindow = false;
  bool _temphidden = false;
  ParkingPlace _parkingPlace;
  double _leftMargin;
  double _topMargin;

  void rebuildInfoWindow() {
    notifyListeners();
  }

  void updateParkingPlaces(ParkingPlace parkingPlace) {
    _parkingPlace = parkingPlace;
  }

  void updateVisibility(bool visibility) {
    _showInfowindow = visibility;
  }

  void updateInfoWindow(BuildContext context, GoogleMapController controller,
      LatLng location, double infoWindowWidth, double markerOffset) async {
    ScreenCoordinate screenCoordinate =
        await controller.getScreenCoordinate(location);
    double devicePixelRatio =
        Platform.isAndroid ? MediaQuery.of(context).devicePixelRatio : 1.0;
    double left = (screenCoordinate.x.toDouble() / devicePixelRatio) -
        (infoWindowWidth / 2);
    double top =
        (screenCoordinate.y.toDouble() / devicePixelRatio) - markerOffset;

    if (left < 0 || top < 0) {
      _temphidden = true;
    } else {
      _temphidden = false;
      _leftMargin = left;
      _topMargin = top;
    }
  }

  bool get showInfoWindow =>
      (_showInfowindow == true && _temphidden == false ? true : false);

  double get leftMargin => _leftMargin;
  double get topMargin => _topMargin;
  ParkingPlace get parkingPlace => _parkingPlace;
}
