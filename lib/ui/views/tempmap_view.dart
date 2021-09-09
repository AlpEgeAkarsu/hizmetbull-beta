import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TempMapView extends StatefulWidget {
  @override
  _TempMapViewState createState() => _TempMapViewState();
}

class _TempMapViewState extends State<TempMapView> {
  userLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(position.latitude, position.longitude));
    var first = addresses.first;
    print(position);
    print(first.addressLine);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: Column(
            children: [
              // GoogleMap(
              //   initialCameraPosition:
              //       CameraPosition(target: LatLng(40.1885, 29.0610), zoom: 11),
              // ),
              TextButton(
                  onPressed: () {
                    userLocation();
                  },
                  child: Text("Anlık Konum"))
            ],
          ),
        ),
      ),
    );
  }
}
