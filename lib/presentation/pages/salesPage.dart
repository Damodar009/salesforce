import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'attendence/attendenceWidget.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  bool showAttendence = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: LatLng(51.5, -0.09),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              attributionBuilder: (_) {
                return const Text("© OpenStreetMap contributors");
              },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  point: LatLng(51.5, -0.09),
                  builder: (ctx) => Container(
                    height: 5,
                    width: 5,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
        Visibility(
            visible: showAttendence, child: Center(child: attendenceWidget())),
      ],
    );
  }
}
