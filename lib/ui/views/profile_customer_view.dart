import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/chat_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/chatroomstore_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/comment_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/image_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/map_controller.dart';
import 'package:hizmet_bull_beta/models/evaluation.dart';
import 'package:hizmet_bull_beta/ui/views/chatstore_view.dart';

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

createChatRoom(
    String userId, String userId2, String username1, String username2) {
  List<String> users = [username1, username2];

  String chatRoomId = userId + "_" + userId2;

  Map<String, dynamic> chatRoom = {
    "users": users,
    "chatRoomId": chatRoomId,
    "user1Approve": false,
    "user2Approve": false
  };

  Get.put(ChatRoomStoreController()).addChatRoom(chatRoom, chatRoomId);
}

class ProfileCustomerView extends GetWidget<FirebaseAuthController> {
  final TextEditingController descriptionController =
      new TextEditingController();
  CommentController commentController = Get.put(CommentController());
  ChatController chatController = Get.put(ChatController());
  ImageController imageController = Get.put(ImageController());
  int arg = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final String currentUserUID = box.read('userUID');
    // commentController.currentPageUID.value = controller.userlistoo[arg].uid;

    // commentController.getUserComments();

    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: IconButton(
                onPressed: () {
                  if (box.read("userType") == 1) {
                    createChatRoom(
                        currentUserUID,
                        controller.userlistoo[arg].uid,
                        box.read("name"),
                        controller.userlistoo[arg].name);

                    Get.toNamed("/chatStoreView", arguments: arg);
                  } else {
                    Get.snackbar("Uyarı",
                        "Mesaj gönderebilmek için hizmet alan olmalısınız !");
                  }
                },
                icon: Icon(Icons.messenger),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                avatarNameStar(box, controller, commentController),
                SizedBox(
                  height: 30,
                ),
                // profileInformationLabels(
                //     firstLabel: "Doğum Tarihi", secondLabel: "-"),
                // basicSpacer(),
                profileInformationLabels(
                    secondLabel: controller.userlistoo[arg].city),
                basicSpacer(),
                profileInformationLabels(
                    firstLabel: "Meslek:",
                    secondLabel: controller.userlistoo[arg].job),
                basicSpacer(),
                profileInformationLabels(
                    firstLabel: "Mail Adres:",
                    secondLabel: controller.userlistoo[arg]?.email),
                basicSpacer(),
                profileInformationLabels(
                    firstLabel: "Telefon Numarası:",
                    secondLabel: "05333536362"),
                basicSpacer(),
                profileInformationLabels(
                    firstLabel: "Lisans Derecesi:",
                    secondLabel: "Yüksek Lisans"),
                basicSpacer(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.width * 0.8,
                  height: 150,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Wrap(
                    children: [
                      Text(controller.userlistoo[arg].description != null
                          ? controller.userlistoo[arg].description
                          : "")
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Fotoğraflar",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(() => GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemCount: imageController.photoURLS.length == 0
                          ? 1
                          : imageController.photoURLS.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return FullScreenImage(
                                imageUrl: imageController.photoURLS[index],
                                tag: "tag+$index",
                              );
                            }));
                          },
                          child: Container(
                            color: Colors.blue,
                            child: imageController.photoURLS.length == 0
                                ? Container()
                                : Hero(
                                    tag: "tag+$index",
                                    child: Image.network(
                                        imageController.photoURLS[index],
                                        // width: Get.width,
                                        fit: BoxFit.cover),
                                  ),
                          ),
                        );
                      },
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Değerlendirmeler",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(() => ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: Get.height * 0.2,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(),
                                Text(
                                  commentController.comments[index].commentator,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  child: Wrap(
                                    children: [
                                      Obx(
                                        () => Text(commentController
                                                .comments.isNotEmpty
                                            ? commentController
                                                .comments[index].commentContent
                                            : "asd"),
                                      )
                                    ],
                                  ),
                                ),
                                RatingBar.builder(
                                  initialRating:
                                      commentController.userTotalPoint !=
                                              0.0.obs
                                          ? commentController.userTotalPoint /
                                              commentController.comments.length
                                          : 2,
                                  ignoreGestures: true,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                Container(
                  width: Get.width * 0.8,
                  height: 150,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Wrap(
                    children: [
                      Obx(() => Text(Get.put(MapController())
                                  .currentUserAddress
                                  .value !=
                              null
                          ? Get.put(MapController()).currentUserAddress.value
                          : "-"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget basicSpacer() {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Divider(
          color: Colors.black38,
          thickness: 1,
        ),
      ],
    );
  }

  Row profileInformationLabels({String firstLabel, String secondLabel}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            firstLabel != null ? firstLabel : "Şehir:",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(secondLabel != null ? secondLabel : "California",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        )
      ],
    );
  }

  Column avatarNameStar(GetStorage box, FirebaseAuthController authController,
      CommentController commentController) {
    return Column(
      children: [
        CircleAvatar(
          maxRadius: 60,
          foregroundImage: NetworkImage(authController
                      .userlistoo[arg].profilePhotoPath ==
                  null
              ? "https://www.nicepng.com/png/detail/136-1366211_group-of-10-guys-login-user-icon-png.png"
              : authController.userlistoo[arg].profilePhotoPath),
        ),
        SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () async {
            if (box.read("userType") == 1) {
              if (await Get.put(ChatRoomStoreController())
                      .checkIfUsersApprovedEachOther(box.read("userUID") +
                          "_" +
                          authController.userlistoo[arg].uid) ==
                  true) {
                Get.bottomSheet(BottomSheet(
                  onClosing: () {},
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Aldığın Hizmeti Değerlendir",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          RatingBar.builder(
                            initialRating: 3,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                              commentController.customerCommentPoint.value =
                                  rating;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24.0, right: 24, top: 48),
                            child: TextFormField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                  hintText: "Yorum giriniz",
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                UserComment comment = UserComment(
                                    commentDate: DateTime.now().toString(),
                                    commentator: box.read("name"),
                                    commentPoint: commentController
                                                .customerCommentPoint.value !=
                                            null
                                        ? commentController
                                            .customerCommentPoint.value
                                            .toInt()
                                        : 2,
                                    commentContent: descriptionController.text,
                                    commentOwner:
                                        controller.userlistoo[arg].uid);
                                try {
                                  commentController.sendCommentToDB(
                                      comment, controller.userlistoo[arg].uid);

                                  Get.back();
                                  Get.snackbar(
                                      "Başarılı", "Yorumunuz Gönderilmiştir");
                                } catch (e) {}
                              },
                              child: Text("Değerlendirme Gir"))
                        ],
                      ),
                    );
                  },
                ));
              } else
                Get.snackbar(
                    "", "Değerlendirme Girebilmeniz İçin Onay Gerekiyor");
            } else
              Get.snackbar("",
                  "Değerlendirme Girebilmeniz İçin Hizmet Alan Olmalısınız !!");
          },
          child: Obx(() => RatingBarIndicator(
                rating: commentController.userTotalPoint.value != null
                    ? commentController.userTotalPoint.value
                    : 0.0,
                // rating: 2,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 30.0,
                direction: Axis.horizontal,
              )),
        ),
        Text(
          controller.userlistoo[arg].name +
              " " +
              controller.userlistoo[arg].surname,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, fontFamily: "Roboto"),
        ),
      ],
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String tag;

  const FullScreenImage({Key key, this.imageUrl, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: tag,
            child: Image.network(
              imageUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
