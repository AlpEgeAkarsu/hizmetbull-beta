import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomStoreController extends GetxController {
  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) {
    Stream<QuerySnapshot> snapshot = FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();

    return snapshot;
  }

  addMessage(String chatRoomId, chatMessageData) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserChats(String userName) {
    Stream<QuerySnapshot> snapshot = FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: userName)
        .snapshots();

    return snapshot;
  }
}
