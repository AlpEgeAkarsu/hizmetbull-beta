import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:hizmet_bull_beta/models/evaluation.dart';

class CommentController extends GetxController {
  final firebaseDbRef = FirebaseDatabase.instance.reference();
  RxList<UserComment> comments = <UserComment>[].obs;
  RxString currentPageUID = "".obs;
  RxInt userTotalPoint = 0.obs;
  void sendCommentToDB(UserComment comment) {
    firebaseDbRef.child("comments").push().set(comment.toJson());
  }

  // @override
  // void onInit() {
  //   getOneComment();
  //   super.onInit();
  // }

  void getOneComment() async {
    try {
      List<UserComment> commentList = await getComments(currentPageUID.value);
      if (commentList.isNotEmpty) {
        for (int i = 0; i < comments?.length; i++) {
          userTotalPoint += comments[i].commentPoint;
        }
        print(commentList[4].commentContent);
      } else {
        print("Comment list ilk index boş !!");
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<RxList<UserComment>> getComments(String commentOwnerID) async {
    try {
      Map<dynamic, dynamic> commentData =
          await readCommentFromDB(commentOwnerID);
      if (commentData != null) {
        commentData.forEach((key, value) {
          var comment = UserComment.fromJson(value);
          comments.add(comment);
        });
      } else {
        print("bok");
      }
    } catch (e) {
      print("$e");
    }
    return comments;
  }

  Future<dynamic> readCommentFromDB(String commentOwnerID) async {
    try {
      var ref = firebaseDbRef
          .child("comments")
          .orderByChild("commentOwner")
          .equalTo(commentOwnerID);
      return await ref.once().then((DataSnapshot snapshot) => snapshot.value);
    } catch (e) {
      print("$e");
    }
  }
}
