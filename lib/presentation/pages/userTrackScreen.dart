import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';
import '../../utils/app_colors.dart';
import '../../utils/geolocation.dart';
import '../../utils/hiveConstant.dart';

class UserTrackScreen extends StatefulWidget {
  const UserTrackScreen({Key? key}) : super(key: key);

  @override
  State<UserTrackScreen> createState() => _UserTrackScreenState();
}

class _UserTrackScreenState extends State<UserTrackScreen> {
  List<LatLng> points = [];
  LatLng? currentPosition;
  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  getLocationDateFromHive() async {
    Box locationBox;
    locationBox = await Hive.openBox(HiveConstants.salesPersonLocationTrack);
    List values = locationBox.values.toList();
    setState(() {
      for (int i = 0; i < values.length; i++) {
        points.add(LatLng(values[i].latitude, values[i].longitude));
      }
      GeoLocationData geoLocation = GeoLocationData();
      double distance = geoLocation.calculateTotalSalesTrackDistance(points);
      print("5555555555555555555555555555555555555555555555555555555555");
      print(distance);
    });
  }

  @override
  initState() {
    super.initState();
    getCurrentLocation();
    getLocationDateFromHive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPosition != null || points.isNotEmpty
          ? FlutterMap(
              options: MapOptions(
                center: points.isNotEmpty
                    ? points[0]
                    : LatLng(
                        currentPosition!.latitude, currentPosition!.longitude),
                zoom: 15.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      point: points.isNotEmpty
                          ? points[0]
                          : LatLng(currentPosition!.latitude,
                              currentPosition!.longitude),
                      builder: (ctx) => const Icon(
                        Icons.pin_drop,
                        color: AppColors.primaryColor,
                        size: 30,
                      ),
                    ),
                    Marker(
                      point: points.isNotEmpty
                          ? points[points.length - 1]
                          : LatLng(currentPosition!.latitude,
                              currentPosition!.longitude),
                      builder: (ctx) => const Icon(
                        Icons.pin_drop_outlined,
                        color: AppColors.buttonColor,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                PolylineLayerOptions(polylines: [
                  Polyline(
                      points: points,
                      isDotted: false,
                      strokeWidth: 3.0,
                      color: AppColors.primaryColor)
                ])
              ],
            )
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
                SizedBox(
                  height: 12,
                ),
                Text("Please wait for a sec...")
              ],
            )),
    );
  }
}
