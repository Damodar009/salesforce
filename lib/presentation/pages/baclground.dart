import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';

class MyBackground extends StatefulWidget {
  const MyBackground({Key? key}) : super(key: key);

  @override
  _MyBackgroundState createState() => _MyBackgroundState();
}

class _MyBackgroundState extends State<MyBackground> {
  String latitude = 'waiting...';
  String longitude = 'waiting...';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Location Service'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            locationData('Latitude: ' + latitude),
            locationData('Longitude: ' + longitude),
            ElevatedButton(
                onPressed: () async {
                  await BackgroundLocation.setAndroidNotification(
                    title: 'Background service is running',
                    message: 'Background location in progress',
                    icon: '@mipmap/ic_launcher',
                  );
                  BackgroundLocation().getCurrentLocation().then((location) {
                    print('This is not background Location ' +
                        location.toMap().toString());
                    setState(() {
                      latitude = location.latitude.toString();
                      longitude = location.longitude.toString();
                    });
                  });
                  await BackgroundLocation.setAndroidConfiguration(1000);
                  await BackgroundLocation.startLocationService(
                      distanceFilter: 0.1);
                  print("distance filter 2 ");

                  BackgroundLocation.getLocationUpdates((location) {
                    print(location);
                    print("this is working");
                    setState(() {
                      print("this is running succesfully ");
                      latitude = location.latitude.toString();
                      longitude = location.longitude.toString();
                    });
                    print('''\n
                        Latitude:  $latitude
                        Longitude: $longitude

                      ''');
                  });
                },
                child: Text('Start Location Service')),
            ElevatedButton(
                onPressed: () {
                  BackgroundLocation.stopLocationService();
                },
                child: Text('Stop Location Service')),
            ElevatedButton(
                onPressed: () {
                  getCurrentLocation();
                },
                child: Text('Get Current Location')),
          ],
        ),
      ),
    );
  }

  Widget locationData(String data) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }

  void getCurrentLocation() {
    BackgroundLocation().getCurrentLocation().then((location) {
      print('This is current Location ' + location.toMap().toString());
    });
  }

  @override
  void dispose() {
    BackgroundLocation.stopLocationService();
    super.dispose();
  }
}
