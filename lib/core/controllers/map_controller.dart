import 'package:firebase_database/firebase_database.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var currentUserAddress = "".obs;
  final firebaseDbRef = FirebaseDatabase.instance.reference();
  final key = 'YOUR_KEY';

  userLocation(String userid) async {
    // get current position (lat/lng) of user
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // get current address of user with coordinates
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(position.latitude, position.longitude));

    latitude.value = position.latitude;
    longitude.value = position.longitude;

    var first = addresses.first;

    // save the address to realtime database with given userid
    try {
      await firebaseDbRef
          .child("users")
          .child(userid)
          .child("address")
          .set(addresses.first.addressLine);
      print(position);
      print(first.addressLine);
      currentUserAddress.value = first.addressLine;
    } catch (e) {
      print(e);
    }

    Map<String, dynamic> location = {
      "latitude": position.latitude,
      "longitude": position.longitude
    };
    this.latitude.value = position.latitude;
    this.longitude.value = position.longitude;
    try {
      await firebaseDbRef
          .child("users")
          .child(userid)
          .child("location")
          .set(location);
    } catch (e) {
      print(e);
    }
  }

  getUserCurrentLocation(String uid) async {
    try {
      await firebaseDbRef
          .child("users")
          .child(uid)
          .child("location")
          .once()
          .then((value) {
        print(value.value["latitude"]);
        print(value.value["longitude"]);
        latitude.value = value.value["latitude"];
        longitude.value = value.value["longitude"];
      });
    } catch (e) {}
  }

  // get user address from realtime db
  Future<void> getUserCurrentAdressFromDb(String uid) async {
    await firebaseDbRef
        .child("users")
        .child(uid)
        .child("address")
        .once()
        .then((value) {
      currentUserAddress.value = value.value;
    });
  }
}
