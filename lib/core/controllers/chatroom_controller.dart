import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  final firebaseDbRef = FirebaseDatabase.instance.reference();
  RxList<dynamic> chatRoomIds = [].obs;
  RxList<dynamic> userIds = [].obs;
  RxList<dynamic> userNames = [].obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getUserChatRooms(String userId) async {
    Map mapdata;
    var test3;
    chatRoomIds.clear();
    userIds.clear();
    await firebaseDbRef
        .child("userChatRooms")
        .child("users")
        .child(userId)
        .once()
        .then((snapshot) {
      if (snapshot.value != null) {
        snapshot.value.forEach(
          (index, data) {
            mapdata = data;
            test3 = mapdata.values;
          },
        );
      } else
        print("sıkıntı");
    });
    chatRoomIds.addAll(test3);
    print("chat room Ids  = " + chatRoomIds.toString());
    await getChatRoomDetails();
    await getUserByUID();
  }

  Future<void> getChatRoomDetails() async {
    for (var i = 0; i < chatRoomIds.length; i++) {
      await firebaseDbRef
          .child("chats")
          .child(chatRoomIds[i])
          .child("sender2UID")
          .once()
          .then((data) {
        print("getchatroomdetails data.value = " + data.value);
        userIds.add(data.value);
      });
    }

    print("userIds = " + userIds.toString());
  }

  Future<void> getUserByUID() async {
    for (var i = 0; i < userIds.length; i++) {
      await firebaseDbRef
          .child("users")
          .child(userIds[i])
          .child("name")
          .once()
          .then((data) {
        print("getuserbyUID data.value = " + data.value);
        userNames.add(data.value);
      });
    }
  }
}
