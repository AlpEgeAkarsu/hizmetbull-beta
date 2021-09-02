import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hizmet_bull_beta/models/chat.dart';
import 'package:hizmet_bull_beta/models/chat_message.dart';

class ChatController extends GetxController {
  final firebaseDbRef = FirebaseDatabase.instance.reference();
  var messagelist = [].obs;
  RxString secondUserName = "".obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> createChatRoom(String user1UID, String user2UID) async {
    Chat chat = new Chat(
      sender1Uid: user1UID,
      sender2Uid: user2UID,
    );

    var val = await readRoomFromDB(user1UID + "_" + user2UID);
    if (val != null) {
      var test = await getMessageList(user1UID + "_" + user2UID);
      messagelist.addAll(test);
      return;
    } else
      firebaseDbRef
          .child("chats")
          .child("$user1UID" + "_" + "$user2UID")
          .set(chat.toJson());
    setUserChatRooms(user1UID, user1UID + "_" + user2UID);
    setUserChatRooms(user2UID, user1UID + "_" + user2UID);
  }

  Future<void> enterChatRoomUserView(String chatRoomId) async {
    messagelist.clear();
    var temp = await getMessageList(chatRoomId);
    messagelist.addAll(temp);
    temp.clear();
  }

  sendMessageUserView(String chatRoomId, String content, String senderId) {
    var message = new Message(
        sentBy: senderId,
        messageDate: DateTime.now().toString(),
        content: content);

    firebaseDbRef
        .child("chats")
        .child(chatRoomId)
        .child("messages")
        .push()
        .update(message.toJson());

    messagelist.add(message);
  }

  Future<void> getUserName(String userId) async {
    await firebaseDbRef
        .child("users")
        .child(userId)
        .child("name")
        .once()
        .then((data) {
      secondUserName.value = data.value;
    });
  }

  Future<dynamic> readRoomFromDB(String chatID) async {
    try {
      var ref = firebaseDbRef.child("chats").orderByKey().equalTo(chatID);
      return await ref.once().then((DataSnapshot snapshot) => snapshot.value);
    } catch (e) {
      print("$e");
    }
  }

  Future<RxList<dynamic>> getMessageList(String roomId) async {
    Map mapdata;
    var messageList = [].obs;
    await firebaseDbRef
        .child("chats")
        .child(roomId)
        .child("messages")
        .orderByChild("messageDate")
        .once()
        .then((snapshot) {
      if (snapshot.value != null) {
        snapshot.value.forEach(
          (index, data) {
            mapdata = data;

            var test = Map<String, dynamic>.from(mapdata);
            Message message = Message.fromJson(test);
            messageList.add(message);
            print(message.content);

            // print(test);
          },
        );
      }
    });
    return messageList;
  }

  addMessagesToChatRoom(String content, String userid1, String userid2) {
    var message = new Message(
        sentBy: userid1,
        content: content,
        messageDate: DateTime.now().toString());

    firebaseDbRef
        .child("chats")
        .child(userid1 + "_" + userid2)
        .child("messages")
        .push()
        .update(message.toJson());

    messagelist.add(message);
  }

  setUserChatRooms(String userId, String roomId) {
    firebaseDbRef
        .child("userChatRooms")
        .child("users")
        .child(userId)
        .child("chatRooms")
        .push()
        .set(roomId);
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////

}
