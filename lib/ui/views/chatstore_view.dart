import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/chatroomstore_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/form_controller.dart';

class ChatStoreView extends StatefulWidget {
  @override
  _ChatStoreViewState createState() => _ChatStoreViewState();
}

class _ChatStoreViewState extends State<ChatStoreView> {
  ChatRoomStoreController storeController = Get.put(ChatRoomStoreController());

  final box = GetStorage();

  Stream<QuerySnapshot> chats;
  FirebaseAuthController authController = Get.put(FirebaseAuthController());

  var arg = Get.arguments;
  @override
  void initState() {
    setState(() {
      chats = storeController.getChats(
          box.read("userUID") + "_" + authController.userlistoo[arg].uid);
    });
    super.initState();
  }

  Widget chatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.docs[index].data()["message"],
                    sendByMe: box.read("name") ==
                        snapshot.data.docs[index].data()["sendBy"],
                  );
                })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentUserUID = box.read("userUID");

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
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            chatMessages(),
            getBottomBar(authController, currentUserUID, arg)
          ],
        ),
      ),
    );
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
          hintText: "",
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
          addMessage(box.read("userUID"), receiverId,
              Get.put(FormController()).messageFieldController.text);
          Get.put(FormController()).messageFieldController.text = "";
        },
        child: Icon(Icons.send),
      ),
    );
  }

  addMessage(String userUID, String user2UID, String messageContent) {
    Map<String, dynamic> chatMessageMap = {
      "sendBy": box.read("name"),
      "message": messageContent,
      'time': DateTime.now().millisecondsSinceEpoch,
    };

    storeController.addMessage(userUID + "_" + user2UID, chatMessageMap);
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                  : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
