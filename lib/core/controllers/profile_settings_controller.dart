import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hizmet_bull_beta/models/users.dart';

class ProfileSettingsController extends GetxController {
  var firebaseDbRef = FirebaseDatabase.instance.reference();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUserData = GetStorage();
  // UPDATE USER DATA WITHOUT CITY AND JOB
  Future<void> changeSingleField(
      String uid, String whatWillChange, String newContent) async {
    try {
      await firebaseDbRef
          .child("users")
          .child(uid)
          .child(whatWillChange)
          .set(newContent);
      Get.defaultDialog(
          title: "Güncelleme Başarılı",
          middleText:
              "Yenilenmiş Ayarlarınızı Görebilmek İçin Lütfen Yeniden Giriş Yapınız");
    } catch (e) {
      print(e);
      Get.snackbar("", "$e");
    }
  }

  // UPDATE USER JOB

  Future<void> changeJob(String uid, String content) async {
    var tempCity;
    // read city first
    firebaseDbRef.child("users").child(uid).child("city").once().then((value) {
      tempCity = value.value;
    });
    // update job data and update job city
    try {
      await firebaseDbRef
          .child("users")
          .child(uid)
          .child("job")
          .set(content)
          .then((value) {
        firebaseDbRef
            .child(uid)
            .child("jobCity")
            .set(content + "_" + tempCity)
            .onError((error, stackTrace) => print(error));
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> changeCity(String uid, String content) async {
    var tempJob;
    // read job first
    firebaseDbRef.child("users").child(uid).child("job").once().then((value) {
      tempJob = value.value;
    });
    // update city data and update job city
    try {
      await firebaseDbRef
          .child("users")
          .child(uid)
          .child("city")
          .set(content)
          .then((value) {
        firebaseDbRef
            .child(uid)
            .child("jobCity")
            .set(content + "_" + tempJob)
            .onError((error, stackTrace) => print(error));
      });
    } catch (e) {
      print(e);
    }
  }

  changePassword(String newPassword) async {
    var tempUser = _auth.currentUser;

    try {
      await tempUser.updatePassword(newPassword);
      Get.snackbar("Başarılı", "Şifre Değiştirildi");
    } catch (e) {
      Get.snackbar("Başarısız", "Şifre Değiştirilemedi");
    }
  }
}
