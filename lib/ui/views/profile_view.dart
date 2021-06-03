import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/comment_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/image_controller.dart';
import 'package:hizmet_bull_beta/ui/widgets/profile_widgets.dart';

class ProfileView extends GetWidget<FirebaseAuthController> {
  final box = GetStorage();
  CommentController commentController = Get.put(CommentController());
  ImageController imageController = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    commentController.currentPageUID.value = box.read("userUID");

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
      body: box.read('userType') == 2
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    avatarNameStar(box),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: profileInformationLabels(
                          secondLabel: box.read('city')),
                    ),
                    basicSpacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: profileInformationLabels(
                          firstLabel: "Meslek:", secondLabel: box?.read('job')),
                    ),
                    basicSpacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: profileInformationLabels(
                          firstLabel: "Mail Adres:",
                          secondLabel: box.read('email') ?? "jane@gmail.com"),
                    ),
                    basicSpacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: profileInformationLabels(
                          firstLabel: "Telefon Numarası:",
                          secondLabel: "05333536362"),
                    ),
                    basicSpacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: profileInformationLabels(
                          firstLabel: "Lisans Derecesi:",
                          secondLabel: "Yüksek Lisans"),
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Fotoğraflar",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              imageController.selectFile();
                            },
                            icon: Icon(Icons.add_a_photo)),
                      ],
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                                      commentController
                                          .comments[index].commentator,
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
                                                    .comments[index]
                                                    .commentContent
                                                : "asd"),
                                          )
                                        ],
                                      ),
                                    ),
                                    RatingBar.builder(
                                      initialRating: commentController
                                                  .userTotalPoint !=
                                              0.obs
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
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: Get.width * 0.8,
                      height: 150,
                      decoration: BoxDecoration(border: Border.all()),
                      child: Wrap(
                        children: [Text("Adres")],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Konuma Git",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : userType1Page(),
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
          child: Text(secondLabel != null ? secondLabel : "-",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        )
      ],
    );
  }

  Column avatarNameStar(GetStorage box) {
    return Column(
      children: [
        CircleAvatar(
          maxRadius: 60,
          foregroundImage: AssetImage("assets/images/exampleAvatar.png"),
        ),
        SizedBox(
          height: 30,
        ),
        RatingBarIndicator(
          rating: 2.75,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 30.0,
          direction: Axis.horizontal,
        ),
        Text(
          box.read('name') != null
              ? box.read('name') + " " + box.read('surname')
              : "asd",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, fontFamily: "Roboto"),
        ),
      ],
    );
  }

  SingleChildScrollView userType1Page() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 60,
              foregroundImage: AssetImage("assets/images/exampleAvatar.png"),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              box.read('name') + " " + box?.read('surname') ?? 'Null',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: "Roboto"),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: profileInformationLabels(secondLabel: box?.read('city')),
            ),
            basicSpacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: profileInformationLabels(
                  firstLabel: "Meslek:", secondLabel: box?.read('job')),
            ),
            basicSpacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: profileInformationLabels(
                  firstLabel: "Mail Adres:",
                  secondLabel: box?.read('email') ?? "jane@gmail.com"),
            ),
            basicSpacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: profileInformationLabels(
                  firstLabel: "Telefon Numarası:", secondLabel: "-"),
            ),
          ],
        ),
      ),
    );
  }
}
