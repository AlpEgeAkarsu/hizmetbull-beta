import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/chat_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/form_controller.dart';

class MessengerView extends GetWidget<ChatController> {
  const MessengerView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FirebaseAuthController authController = Get.put(FirebaseAuthController());
    final box = GetStorage();
    final String currentUserUID = box.read('userUID');
    int arg = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        authController.userlistoo[arg].name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.verified,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: body(authController, currentUserUID, arg),
    );
  }

  Widget body(
      FirebaseAuthController authController, String currentUserUID, int arg) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          getMessageList(authController, currentUserUID, arg),
          getBottomBar(authController, currentUserUID, arg),
        ],
      ),
    );
  }

  Widget getMessageList(
      FirebaseAuthController authController, String currentUserUID, int arg) {
    return Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: Obx(() => ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: controller.messagelist.length,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                  child: Align(
                    alignment: controller.messagelist[index].sentBy ==
                            authController.userlistoo[arg].uid
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green),
                      child: Text(controller.messagelist[index].content),
                    ),
                  ),
                );
              },
            )));
  }

  Widget getBottomBar(
      FirebaseAuthController authController, String currentUserUID, int arg) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16, bottom: 10, top: 10),
        height: 70,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: [
            getMessageTextField(),
            getSendMessageButton(authController, currentUserUID, arg)
          ],
        ),
      ),
    );
  }

  Widget getMessageTextField() {
    return Expanded(
      child: TextFormField(
        controller: Get.put(FormController()).messageFieldController,
        decoration: InputDecoration(
          hintText: "ASFASF",
          contentPadding: EdgeInsets.only(left: 8),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.amber)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.amber)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.amber)),
        ),
      ),
    );
  }

  Widget getSendMessageButton(
      FirebaseAuthController authController, String currentUserUID, int arg) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          var receiverId = authController.userlistoo[arg].uid;
          controller.addMessagesToChatRoom(
              Get.put(FormController()).messageFieldController.text,
              currentUserUID,
              receiverId);
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          Get.put(FormController()).messageFieldController.clear();
        },
        child: Icon(Icons.send),
      ),
    );
  }
}
