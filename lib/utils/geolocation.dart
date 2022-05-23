import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@singleton
class GeoLocationData {
  Future<Position?> getCurrentLocation() async {

    Position? position;
    //final Geolocator geolocator = Geolocator();
    bool servicEnabled;

    servicEnabled = await Geolocator.isLocationServiceEnabled();

    if (!servicEnabled) {
      checkLocationPermission();
    } else {
      checkLocationPermission();
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
      if (permission == LocationPermission.denied) {}
    }
  }
}
