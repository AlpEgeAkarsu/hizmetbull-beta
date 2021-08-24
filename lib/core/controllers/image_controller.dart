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
  final firebaseDbRef = FirebaseDatabase.instance.reference();
  final box = GetStorage();
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    final path = result.files.single.path;

    file = File(path);
    uploadFile();
  }

  Future uploadFile() async {
    if (file == null) return;
    final fileName = basename(file.path);
    final destination = 'files/' + box.read("userUID") + "/" + fileName;
    uploadToDBFile(destination, file);
  }

  Future<void> uploadToDBFile(String destination, File file) async {
    try {
      var uploadTask = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .putFile(file);
      var imageUrl = await (await uploadTask).ref.getDownloadURL();
      var url = imageUrl.toString();
      print(url);
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
  }

  Future<void> getImageList() async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    firebase_storage.ListResult result = await storage
        .ref()
        .child('files/')
        .child(box.read("userUID"))
        .listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });

    result.prefixes.forEach((firebase_storage.Reference ref) {
      print('Found directory: $ref');
    });
  }
}
