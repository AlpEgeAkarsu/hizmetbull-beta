import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';

class ImageController extends GetxController {
  File file;
  RxList<dynamic> photoURLS = [].obs;
  final firebaseDbRef = FirebaseDatabase.instance.reference();
  final box = GetStorage();
  final userProfilePhotoURL = 'getx'.obs;
  Future selectFile({bool isProfilePhoto = false}) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    final path = result.files.single.path;

    file = File(path);
    uploadFile(isProfilePhoto: isProfilePhoto);
  }

  Future uploadFile({bool isProfilePhoto = false}) async {
    if (file == null) return;
    final fileName = basename(file.path);
    final destination = 'files/' + box.read("userUID") + "/" + fileName;
    uploadToDBFile(destination, file, isProfilePhoto: isProfilePhoto);
  }

  Future<void> uploadToDBFile(String destination, File file,
      {bool isProfilePhoto = false}) async {
    try {
      var uploadTask = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .putFile(file);
      var imageUrl = await (await uploadTask).ref.getDownloadURL();
      var url = imageUrl.toString();
      // print(url);
      if (isProfilePhoto) uploadUserProfilePhotoURL(box.read("userUID"), url);
    } on FirebaseException catch (e) {
      print("$e");
      return null;
    }
  }

  Future<void> uploadUserProfilePhotoURL(String uid, String photoPath) async {
    await firebaseDbRef
        .child("users")
        .child(uid)
        .child("profilePhotoPath")
        .set(photoPath);
    box.write("profilePhotoPath", photoPath);
    Get.defaultDialog(
        title: "Fotoğraf Güncellendi",
        middleText: "Profil Fotoğrafınız Güncellendi");
  }

  Future<void> getUserProfilePhotoURL(String uid) async {
    await firebaseDbRef
        .child("users")
        .child(uid)
        .child("profilePhotoPath")
        .once()
        .then((value) {
      box.write("profilePhotoPath", value.value);
      //   userProfilePhotoURL.value = value.value;
      //  print(value.value);
    });
  }

  Future<void> getImageList({String userUID}) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    firebase_storage.ListResult result = await storage
        .ref()
        .child('files/')
        .child(userUID == null ? box.read("userUID") : userUID)
        .listAll();

    result.items.forEach((firebase_storage.Reference ref) async {
      // print('Found file: $ref');
      photoURLS.add(await getDownloadURL(ref.name,
          userid: userUID == null ? box.read('userUID') : userUID));
      // print(photoURLS.toString());
    });

    // result.prefixes.forEach((firebase_storage.Reference ref) {
    //   print('Found directory: $ref');
    // });
  }

  Future<String> getDownloadURL(String filename, {String userid}) async {
    String downloadURL;
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    var ref = storage.ref();
    await ref
        .child('files/')
        .child(userid == null ? box.read("userUID") : userid)
        .child(filename)
        .getDownloadURL()
        .then((value) {
      downloadURL = value;
    });
    return downloadURL.toString();
  }
}
