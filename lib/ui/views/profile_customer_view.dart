import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/comment_controller.dart';
import 'package:hizmet_bull_beta/models/evaluation.dart';

class ProfileCustomerView extends GetWidget<FirebaseAuthController> {
  final box = GetStorage();
  final TextEditingController descriptionController =
      new TextEditingController();
  CommentController commentController = Get.put(CommentController());
  int arg = Get.arguments;

  @override
  Widget build(BuildContext context) {
    commentController.currentPageUID.value = controller.userlistoo[arg].uid;

    commentController.getOneComment();

    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: IconButton(
                onPressed: () {
                  Get.toNamed("/profileSettingsView");
                },
                icon: Icon(Icons.settings),
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
                profileInformationLabels(
                    firstLabel: "Doğum Tarihi", secondLabel: "-"),
                basicSpacer(),
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
                      Text(
                          "Şurda Okudum şöyle yaptım,böyle yaptım...Şurda Okudum şöyle yaptım,böyle yaptım...Şurda Okudum şöyle yaptım,böyle yaptım...")
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
                GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Text("He'd have you all unravel at the"),
                      color: Colors.teal[100],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Heed not the rabble'),
                      color: Colors.teal[200],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Sound of screams but the'),
                      color: Colors.teal[300],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Who scream'),
                      color: Colors.teal[400],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Revolution is coming...'),
                      color: Colors.teal[500],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text('Revolution, they...'),
                      color: Colors.teal[600],
                    ),
                  ],
                ),
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
                                      commentController.userTotalPoint != 0.obs
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
                    children: [Text("Adres")],
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
          foregroundImage: AssetImage("assets/images/exampleAvatar.png"),
        ),
        SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            box.read('userType') == 1
                ? Get.bottomSheet(BottomSheet(
                    onClosing: () {},
                    builder: (context) {
                      return Column(
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
                            ignoreGestures: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
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
                                    commentDate: "29.05.2021",
                                    commentator: box.read("name"),
                                    commentPoint: 1,
                                    commentContent:
                                        "Her şeasfasfasfysafasfafasfasf için asfasfasf",
                                    commentOwner:
                                        controller.userlistoo[arg].uid);

                                commentController.sendCommentToDB(comment);
                              },
                              child: Text("Değerlendirme Gir"))
                        ],
                      );
                    },
                  ))
                : Get.snackbar("",
                    "Değerlendirme Girebilmeniz İçin Hizmet Alan Olmalısınız !!");
          },
          child: Obx(() => RatingBarIndicator(
                rating: commentController.userTotalPoint != 0.obs
                    ? commentController.userTotalPoint /
                        commentController.comments.length
                    : 0,
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
