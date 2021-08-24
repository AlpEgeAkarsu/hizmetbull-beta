import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hizmet_bull_beta/core/controllers/chat_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/chatroom_controller.dart';
import 'package:hizmet_bull_beta/ui/views/messenger_view.dart';

class MessengerRoomView extends GetWidget<ChatRoomController> {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    ChatController chatController = Get.put(ChatController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Mesajlar"),
      ),
      body: Obx(() => ListView.builder(
            itemCount: controller.userIds.length ?? 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed("/messengerUserView",
                      arguments: controller.chatRoomIds[index]);
                },
                child: ListTile(
                  leading: CircleAvatar(),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.userNames[index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("son mesaj")
                    ],
                  ),
                  tileColor: index.isEven ? Colors.grey[300] : Colors.white,
                ),
              );
            },
          )),
    );
  }
}
