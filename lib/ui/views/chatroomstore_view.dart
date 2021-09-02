import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/chatroomstore_controller.dart';

class ChatRoomStoreView extends StatefulWidget {
  @override
  _ChatRoomStoreViewState createState() => _ChatRoomStoreViewState();
}

class _ChatRoomStoreViewState extends State<ChatRoomStoreView> {
  Stream<QuerySnapshot> chatRooms;
  final box = GetStorage();
  Stream<QuerySnapshot> chats;
  FirebaseAuthController authController = Get.put(FirebaseAuthController());
  ChatRoomStoreController storeController = Get.put(ChatRoomStoreController());
  Widget chatRoomsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.docs[index]
                        .data()['users']
                        .toString()
                        .replaceAll(box.read("name"), "")
                        .replaceAll(new RegExp(r'[^\w\s]+'), ""),
                    chatRoomId: snapshot.data.docs[index].data()["chatRoomId"],
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    chatRooms = storeController.getUserChats(box.read("name"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mesajlar",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: chatRoomsList(),
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName, @required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Map<String, String> chatRoomIdAsMap = {
              "roomId": chatRoomId,
              "secondUserName": userName
            };
            Get.toNamed("/chatStoreUserView", parameters: chatRoomIdAsMap);
          },
          child: ListTile(
            leading: CircleAvatar(),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("son mesaj")
              ],
            ),
          ),
        ),
      ],
    );
  }
}
