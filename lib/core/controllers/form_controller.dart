import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  // GENERAL TEXTFIELDS
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  TextEditingController jobController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController messageFieldController = new TextEditingController();

  // SETTINGS TEXTFIELDS
  TextEditingController settingsPasswordController =
      new TextEditingController();
  TextEditingController settingsNameController = new TextEditingController();
  TextEditingController settingsEmailController = new TextEditingController();
  TextEditingController settingsSurnameController = new TextEditingController();
  TextEditingController settingsPhoneController = new TextEditingController();
  TextEditingController settingsDescriptionController =
      new TextEditingController();
  TextEditingController settingsAddressController = new TextEditingController();
  TextEditingController settingsJobController = new TextEditingController();
  TextEditingController settingsCityController = new TextEditingController();
  TextEditingController settingsLicenseController = new TextEditingController();
  TextEditingController settingsUniversityController =
      new TextEditingController();
}
