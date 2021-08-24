import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/chat_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/chatroom_controller.dart';
import 'package:hizmet_bull_beta/models/users.dart';
import 'package:hizmet_bull_beta/models/suggestion.dart';

class HomeView extends GetWidget<FirebaseAuthController> {
  String currentText;
  TextEditingController jobChoiceController = new TextEditingController();
  TextEditingController cityChoiceController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed("/");
              controller.isJobSelected = false.obs;
              jobChoiceController.clear();
              cityChoiceController.clear();
              print(controller.currentUserData?.read('name').toString());
              print(box?.read('name'));
              print(box?.read('isLoggedIn'));
              print(box?.read('userType').toString());

              Get.snackbar(
                  "",
                  box.read('isLoggedIn').toString() +
                      box.read('name').toString());
            },
            icon: Icon(Icons.home)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    try {
                      box.read('isLoggedIn') == null
                          ? Get.toNamed("/loginView")
                          : Get.toNamed("/profileView");
                    } catch (e) {
                      Get.snackbar("asd", "$e");
                    }
                  },
                ),
                box.read('isLoggedIn') == null
                    ? IconButton(
                        icon: Icon(Icons.person_add),
                        onPressed: () {
                          Get.toNamed("/registerView");
                        },
                      )
                    : Container(),
                box.read('isLoggedIn') == null
                    ? Container()
                    : IconButton(
                        onPressed: () {
                          Get.put(ChatRoomController())
                              .getUserChatRooms(box.read('userUID'));
                          Get.toNamed(
                            "/messengerRoomView",
                          );
                        },
                        icon: Icon(Icons.message))
              ],
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Image.asset("assets/images/mainLogo.png")),
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                          "HİZMETBULL",
                          style: TextStyle(fontSize: 36),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: textFieldAndButton(
                            jobChoiceController,
                            cityChoiceController,
                            controller,
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget textFieldAndButton(TextEditingController controller,
    TextEditingController controller2, FirebaseAuthController authController) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: searchTextField(controller, controller2, authController),
      ),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.only(left: 14.0),
        child: searchButton(controller, controller2, authController),
      ))
    ],
  );
}

Widget searchButton(TextEditingController controller,
    TextEditingController controller2, FirebaseAuthController authController) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: Colors.grey,
        side: BorderSide(
          color: Colors.black,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)))),
    onPressed: () async {
      var job = controller.text;
      authController.setJobSelected(true);
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      authController.userlistoo.clear();
      var city = controller2?.text;
      try {
        Map<dynamic, dynamic> data =
            await authController.readSpecificData2(job, city: city);
        if (data != null && data.length > 0 && city.length > 0) {
          data.forEach((key, value) {
            var appUser = AppUser.fromJson(value);

            authController.userlistoo.add(appUser);
          });
          print(authController.userlistoo[0].email.toString());
        } else {
          authController.userlistoo.clear();
        }
      } catch (e) {
        Get.snackbar("Hata:", ("Lütfen Geçerli Bir Şehir İsmi Giriniz"));
        authController.setJobSelected(false);
      } finally {
        if (authController.userlistoo.isNotEmpty) {
          Get.toNamed("/resultsView");
        } else if (authController.isJobSelected.value && city != "") {
          Get.snackbar("Deneme", "Hizmet Bulunamadı");
        } else
          print("");
      }
    },
    child: Text(
      "BUL",
      style: TextStyle(fontSize: 24),
    ),
  );
}

Widget searchTextField(
    TextEditingController jobController,
    TextEditingController cityController,
    FirebaseAuthController authController) {
  return TypeAheadField<String>(
    keepSuggestionsOnSuggestionSelected: true,
    hideOnEmpty: false,
    suggestionsBoxController: SuggestionsBoxController(),
    suggestionsBoxDecoration: SuggestionsBoxDecoration(
      color: Colors.white,
    ),
    textFieldConfiguration: TextFieldConfiguration(
        controller: !authController.isJobSelected.value
            ? jobController
            : cityController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: !authController.isJobSelected.value
                ? "HİZMET SEÇ"
                : "ŞEHİR SEÇ")),
    suggestionsCallback: (pattern) {
      return !authController.isJobSelected.value
          ? SuggestionData.getSuggestions(pattern)
          : SuggestionData.getCitySuggestions(pattern);
    },
    itemBuilder: (context, itemData) {
      return ListTile(
        title: Text(itemData),
      );
    },
    onSuggestionSelected: (suggestion) {
      !authController.isJobSelected.value
          ? jobController.text = suggestion
          : cityController.text = suggestion;
    },
  );
}
