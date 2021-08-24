import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/chat_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/form_controller.dart';

class MessengerUserView extends GetWidget<ChatController> {
  FirebaseAuthController authController = Get.put(FirebaseAuthController());
  final box = GetStorage();
  String arg = Get.arguments;

  MessengerUserView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var pos = arg.lastIndexOf('_');
    var lastindex = arg.length;
    String secondUserUID =
        (pos != -1) ? arg.substring(pos + 1, lastindex) : arg;
    print(secondUserUID);
    controller.getUserName(secondUserUID);
    controller.enterChatRoomUserView(arg);
    final String currentUserUID = box.read('userUID');

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
                      Obx(() => Text(
                            controller.secondUserName.value ?? "sagkjsagk",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )),
                      SizedBox(
                        height: 6,
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
      body: body(currentUserUID),
    );
  }

  Widget body(String currentUserUID) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          getMessageList(
            currentUserUID,
          ),
          getBottomBar(
            currentUserUID,
          ),
        ],
      ),
    );
  }

  Widget getMessageList(String currentUserUID) {
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
                    alignment:
                        controller.messagelist[index].sentBy == currentUserUID
                            ? Alignment.topRight
                            : Alignment.topLeft,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: controller.messagelist[index].sentBy ==
                                  currentUserUID
                              ? Colors.grey
                              : Colors.black),
                      child: Text(
                        controller.messagelist[index].content,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            )));
  }

  Widget getBottomBar(
    String currentUserUID,
  ) {
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
            getSendMessageButton(currentUserUID)
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

  Widget getSendMessageButton(String currentUserUID) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          var receiverId = ""; // düzlir
          controller.sendMessageUserView(
              arg,
              Get.put(FormController()).messageFieldController.text,
              currentUserUID);
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          Get.put(FormController()).messageFieldController.clear();
        },
        child: Icon(Icons.send),
      ),
    );
  }
}
