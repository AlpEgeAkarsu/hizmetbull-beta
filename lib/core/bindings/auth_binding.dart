import 'package:get/get.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/comment_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/form_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseAuthController>(() => FirebaseAuthController());
    Get.lazyPut<FormController>(() => FormController());
    Get.lazyPut<CommentController>(() => CommentController());
  }
}
