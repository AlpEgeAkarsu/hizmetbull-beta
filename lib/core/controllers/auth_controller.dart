import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_storage/get_storage.dart';

import 'package:hizmet_bull_beta/models/users.dart';

class FirebaseAuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isJobSelected = false.obs;
  Rxn<User> _firebaseUser = Rxn<User>();
  AppUser appuser;
  final currentUserData = GetStorage();
  var uid;
  List<AppUser> userlistoo = [];

  final firebaseDbRef = FirebaseDatabase.instance.reference();
  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  void setJobSelected(bool val) {
    isJobSelected = val.obs;
    update();
  }

  void createUserTypeOne(
      String name, String surname, String email, String password) async {
    AppUser appUser =
        new AppUser(email: email, name: name, surname: surname, userType: 1);
    appUser.toJson();
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password)
          .then((value) => uid = value.user.uid)
          .then((value) => appUser.uid = uid)
          .then((value) => createUserOnDB(appUser.toJson()));
    } catch (e) {
      Get.snackbar("Bağlantı sağlanamadı", "Sıkıntı");
    }
  }

  // creates user informations for realtime database with users' unique id

  void createUserOnDB(Map<dynamic, dynamic> userData) async {
    firebaseDbRef.child("users").child(uid).set(userData);
  }

  Future<dynamic> readSpecificData2(String job, {String city}) async {
    try {
      var ref = city != null && city.length > 0
          ? firebaseDbRef
              .child("users")
              .orderByChild("jobcity")
              .equalTo("$job" + "_" + "$city")
          : firebaseDbRef.child("users").orderByChild("job").equalTo("$job");

      return await ref.once().then((DataSnapshot snapshot) => snapshot.value);
    } catch (e) {
      Get.snackbar("Hata: ", "$e");
    }
  }

  // this is for professional users
  void createUserTypeTwo(String email, String password, String name,
      String surname, String city, String job) async {
    AppUser appuser = new AppUser(
        name: name,
        surname: surname,
        email: email,
        city: city,
        job: job,
        userType: 2,
        jobcity: "$job" + "_" + "$city");
    appuser.toJson();

    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password)
          .then((value) => uid = value.user.uid)
          .then((value) => appuser.uid = uid)
          .then((value) => createUserOnDB(appuser.toJson()))
          .then((value) async {
        appuser = await getUserInfo(uid);
        currentUserData.write('name', appuser?.name);
        currentUserData.write('surname', appuser?.surname);
        currentUserData.write('email', appuser?.email);
        currentUserData.write('isLoggedIn', true);
        currentUserData.write('job', appuser?.job);
        currentUserData.write('city', appuser?.city);
        currentUserData.write('userType', appuser?.userType);
        currentUserData.write('userUID', appuser?.uid);
        Get.offAllNamed("/");
      });
    } catch (e) {
      Get.snackbar("Bağlantı sağlanamadı", e.message.toString());
    }
  }

  Future<AppUser> getUserInfo(String uid) async {
    var ref = firebaseDbRef.child("users").orderByChild("uid").equalTo(uid);

    return await ref.once().then((DataSnapshot snapshot) {
      return AppUser.fromJson(snapshot.value[uid]);
    });
  }

  // simple login with firebase auth package
  void loginFirebase(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email.trim(), password: password)
          .then((value) async {
        uid = value.user.uid;
        appuser = await getUserInfo(uid);
        currentUserData.write('name', appuser?.name);
        currentUserData.write('surname', appuser?.surname);
        currentUserData.write('email', appuser?.email);
        currentUserData.write('isLoggedIn', true);
        currentUserData.write('profilePhotoPath', appuser?.profilePhotoPath);
        currentUserData.write('job', appuser?.job);
        currentUserData.write('city', appuser?.city);
        currentUserData.write('userType', appuser?.userType);
        currentUserData.write('userUID', appuser?.uid);
        Get.offAllNamed("/");
      });
    } catch (e) {
      print(e.toString());
      Get.snackbar("Bağlantı sağlanamadı", "Nedense sıkıntı var");
    }
  }

  // simple logout
  void signOut() {
    try {
      _auth.signOut();
    } catch (e) {
      Get.snackbar("Kullanıcı Çıkışında Hata Var...", e.message.toString());
    }
  }
}
