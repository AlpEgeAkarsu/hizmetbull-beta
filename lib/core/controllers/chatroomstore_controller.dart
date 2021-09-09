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

  updateChatRoomApprove(String chatRoomId, int userType) async {
    var tempData;
    if (userType == 1) {
      tempData = {"user1Approve": true};
    } else {
      tempData = {"user2Approve": true};
    }
    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .update(tempData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<bool> checkIfUsersApprovedEachOther(String chatRoomId) async {
    var data;
    try {
      await FirebaseFirestore.instance
          .collection("chatRoom")
          .doc(chatRoomId)
          .get()
          .then((value) {
        if (value.data()["user1Approve"] == true &&
            value.data()["user2Approve"] == true) {
          print("Yorum Yapmaya Uygun.");
          data = true;
        } else {
          print("Yorum Yapmaya Uygun Değil");
          data = false;
        }
      });
    } catch (e) {
      print(e.toString());
      data = false;
    }
    return data;
  }

  getUserChats(String userName) {
    Stream<QuerySnapshot> snapshot = FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: userName)
        .snapshots();

    return snapshot;
  }
}
