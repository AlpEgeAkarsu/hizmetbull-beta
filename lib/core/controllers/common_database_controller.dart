import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:hizmet_bull_beta/core/controllers/map_controller.dart';

class CommonDatabaseController extends GetxController {
  var userDescriptionData = "".obs;
  final firebaseDbRef = FirebaseDatabase.instance.reference();

  getCurrentUserDescription(String uid) async {
    try {
      await firebaseDbRef
          .child("users")
          .child(uid)
          .child("description")
          .once()
          .then((value) {
        userDescriptionData.value = value.value;
      });
    } catch (e) {
      print(e);
    }
  }

  getCurrentUserAddress(String uid) async {
    try {
      await firebaseDbRef
          .child("users")
          .child(uid)
          .child("address")
          .once()
          .then((value) {
        Get.put(MapController()).currentUserAddress.value = value.value;
      });
    } catch (e) {
      print(e);
    }
  }

  setUserLocationOnDb(Map<String, dynamic> location, String uid) async {
    try {
      await firebaseDbRef
          .child("users")
          .child(uid)
          .child("location")
          .set(location);
    } catch (e) {}
  }

  setUserSecondaryAddressesOnDb(String address, String uid) async {
    try {
      firebaseDbRef
          .child("users")
          .child(uid)
          .child("addresses")
          .push()
          .set(address);
    } catch (e) {
      print(e);
    }
  }

  setUserAddressOnDb(String address, String uid) async {
    try {
      firebaseDbRef.child("users").child(uid).child("address").set(address);
      Get.put(MapController()).currentUserAddress.value = address;
    } catch (e) {
      Get.snackbar("Başarısız", "Bir Hata Oluştu");
    }
  }

  setUserSecondaryAddressLocationsOnDb(
      Map<String, dynamic> location, String uid) async {
    try {
      await firebaseDbRef
          .child("users")
          .child(uid)
          .child("locations")
          .set(location);
    } catch (e) {}
  }
}
