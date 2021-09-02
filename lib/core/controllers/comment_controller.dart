import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:hizmet_bull_beta/models/evaluation.dart';

class CommentController extends GetxController {
  final firebaseDbRef = FirebaseDatabase.instance.reference();
  RxList<UserComment> comments = <UserComment>[].obs;
  RxString currentPageUID = "".obs;
  RxDouble userTotalPoint = 0.0.obs;
  void sendCommentToDB(UserComment comment, String commentOwnerId) {
    firebaseDbRef
        .child("comments")
        .child(commentOwnerId)
        .push()
        .set(comment.toJson());
  }

  void getUserComments() async {
    try {
      List<UserComment> commentList = await getComments(currentPageUID.value);
      if (commentList.isNotEmpty) {
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

  Future<void> calculateUserPoint(String userid) async {
    Map mapdata;
    RxList<UserComment> tempCommentList = <UserComment>[].obs;
    int totalPoints = 0;
    int i = 0;
    double averagePoint = 0;
    try {
      var ref = firebaseDbRef.child("comments").child(userid);

      await ref.once().then((snapshot) {
        if (snapshot.value != null) {
          snapshot.value.forEach(
            (index, data) {
              mapdata = data;

              var tempMap = Map<String, dynamic>.from(mapdata);
              UserComment userComment = UserComment.fromJson(tempMap);
              tempCommentList.add(userComment);
              totalPoints = totalPoints + userComment.commentPoint;
              i++;
              print(userComment.commentPoint.toString());
              print("Total Points = $totalPoints");
              print("i = $i");
            },
          );
          averagePoint = totalPoints / i;
          userTotalPoint.value = averagePoint;
          updateUserPoint(userid, averagePoint);
          print("usertotalpoint = $userTotalPoint");
          print("Average Point" + averagePoint.toString());
        }
      });
    } catch (e) {}
  }

  Future<void> updateUserPoint(String userid, double point) async {
    await firebaseDbRef
        .child("users")
        .child(userid)
        .child("userPoint")
        .set(point.toString());
  }

  Future<dynamic> readCommentFromDB(String commentOwnerID) async {
    try {
      var ref = firebaseDbRef.child("comments").child(commentOwnerID);

      return await ref.once().then((DataSnapshot snapshot) => snapshot.value);
    } catch (e) {
      print("$e");
    }
  }
}
