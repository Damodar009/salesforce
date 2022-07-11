import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'app_colors.dart';

@singleton
class GeoLocationData {
  Future<Position?> getCurrentLocation() async {
    Position? position;
    bool servicEnabled;
    servicEnabled = await Geolocator.isLocationServiceEnabled();

    if (servicEnabled) {
      checkLocationPermission();
    } else {
      Fluttertoast.showToast(
          msg: "Enable your location service",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          textColor: Colors.white);
      await checkLocationPermission();
    }

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position positio) {
      position = positio;
    });
    return position;
  }

  checkLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  double calculateDistance(LatLng l1, LatLng l2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((l1.latitude - l2.latitude) * p) / 2 +
        c(l1.latitude * p) *
            c(l2.latitude * p) *
            (1 - c((l1.longitude - l2.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }

  double calculateTotalSalesTrackDistance(List<LatLng> locations) {
    double distance = 0;
    LatLng tempLocation = locations[0];
    for (int i = 5; i < locations.length; i += 5) {
      LatLng temp = locations[i];

      if (locations.length > i) {
        distance = distance + calculateDistance(tempLocation, temp);
      }
      tempLocation = temp;
    }
    return distance;
  }
}
