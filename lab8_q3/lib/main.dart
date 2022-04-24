import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const GeoLoc());
}

class GeoLoc extends StatefulWidget {
  const GeoLoc({Key? key}) : super(key: key);

  @override
  State<GeoLoc> createState() => _GeoLocState();
}
var lati;
var longi;
class _GeoLocState extends State<GeoLoc> {
  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
        setState(() {
          lati = position.latitude;
          longi = position.longitude;
        });
    print('called');
    print(position.latitude);
  }
  void checklocationStatus() async {
    LocationPermission Permissions = await Geolocator.checkPermission();
    if (Permissions == LocationPermission.denied) {
      print("Permission Denied");
    } else {
      print("Permission Allowed");
    }
  }

  @override
  initState() {
    checklocationStatus();
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(onPressed: () {
                getLocation();
              }, child: Text('Get Location')),
              FlatButton(onPressed: () {
                checklocationStatus();
              }, child: Text('Permission')),

              Text('Latitude : $lati ,,, Longitude : $longi')
            ],
          ),
        ),
      ),
    );
  }
}