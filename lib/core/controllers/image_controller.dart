import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';

class ImageController extends GetxController {
  File file;
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

  UploadTask uploadToDBFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      print("$e");
      return null;
    }
  }
}
