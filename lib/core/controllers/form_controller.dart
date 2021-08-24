import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  // RxString name = ''.obs;
  // RxString surname = ''.obs;
  // RxString email = ''.obs;
  // RxString password = ''.obs;
  // RxString city = ''.obs;
  // RxString job = ''.obs;
  // RxString errorText = RxString(null);

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // void usernameChanged(String val) {
  //   name.value = val;
  // }
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  TextEditingController jobController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController messageFieldController = new TextEditingController();
  //controller.getMessageList(currentUserUID + "_" + receiverId);
}
