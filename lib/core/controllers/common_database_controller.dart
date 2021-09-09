import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

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
}
