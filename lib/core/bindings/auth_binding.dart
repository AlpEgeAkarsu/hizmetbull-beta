import 'package:get/get.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/chat_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/chatroom_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/chatroomstore_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/comment_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/common_database_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/form_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/image_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/map_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseAuthController>(() => FirebaseAuthController());
    Get.lazyPut<FormController>(() => FormController());
    Get.lazyPut<CommentController>(() => CommentController());
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut<ChatRoomController>(() => ChatRoomController());
    Get.lazyPut<ImageController>(() => ImageController());
    Get.lazyPut<ChatRoomStoreController>(() => ChatRoomStoreController());
    Get.lazyPut<MapController>(() => MapController());
    Get.lazyPut<CommonDatabaseController>(() => CommonDatabaseController());
  }
}
