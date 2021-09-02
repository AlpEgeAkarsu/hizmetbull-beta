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
    // commentController.currentPageUID.value = box.read("userUID");

    // commentController.getUserComments();
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
                    Obx(() => GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
        GestureDetector(
          onTap: () {
            imageController.selectFile(isProfilePhoto: true);
          },
          child: CircleAvatar(
              maxRadius: 60,
              foregroundImage: NetworkImage(
                box.read("profilePhotoPath") == null
                    ? "https://www.nicepng.com/png/detail/136-1366211_group-of-10-guys-login-user-icon-png.png"
                    : box.read("profilePhotoPath"),
              )),
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
            GestureDetector(
              onTap: () {
                Get.put(ImageController()).selectFile(isProfilePhoto: true);
              },
              child: CircleAvatar(
                maxRadius: 60,
                foregroundImage: NetworkImage(
                    // Get.put(ImageController())
                    //             .getUserProfilePhotoURL(box.read("userUID")) ==
                    //         null
                    //     ? "https://firebasestorage.googleapis.com/v0/b/hizmet-bull.appspot.com/o/files%2FlzsmauL8tkevfxD0aNyphkDz5VI3%2Fborweinandroid.jpeg?alt=media&token=488ecc97-2aff-440a-81ce-d748aa2c67d3"
                    //     : Get.put(ImageController())
                    //         .getUserProfilePhotoURL(box.read("userUID")),
                    box.read("profilePhotoPath") == null
                        ? "https://www.nicepng.com/png/detail/136-1366211_group-of-10-guys-login-user-icon-png.png"
                        : box.read("profilePhotoPath")),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              box.read('name') != null && box.read('surname') != null
                  ? box.read('name') + " " + box.read('surname')
                  : 'null',
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
              child: profileInformationLabels(
                  secondLabel: box?.read('city') ?? '-'),
            ),
            basicSpacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: profileInformationLabels(
                  firstLabel: "Meslek:", secondLabel: box?.read('job') ?? '-'),
            ),
            basicSpacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: profileInformationLabels(
                  firstLabel: "Mail Adres:",
                  secondLabel: box?.read('email') ?? "-"),
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
