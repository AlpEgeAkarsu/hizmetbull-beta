import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/comment_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/image_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/map_controller.dart';

class ResultsView extends GetWidget<FirebaseAuthController> {
  CommentController commentController = Get.put(CommentController());
  ImageController imageController = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hizmet Verenler",
          style: TextStyle(fontSize: 18, fontFamily: "Comfortaa"),
        ),
      ),
      body: ListView.builder(
        itemCount:
            controller.userlistoo.isEmpty ? 1 : controller.userlistoo.length,
        itemBuilder: (context, index) {
          // commentController.currentPageUID.value =
          //     controller.userlistoo[index].uid;

          // commentController.getUserComments();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () async {
                print(index.toString());
                await Get.put(ImageController())
                    .getUserProfilePhotoURL(controller.userlistoo[index].uid);
                Get.put(ImageController()).photoURLS.clear();
                await Get.put(ImageController())
                    .getImageList(userUID: controller.userlistoo[index].uid);
                commentController.currentPageUID.value =
                    controller.userlistoo[index].uid;
                commentController.comments.clear();
                commentController.userTotalPoint.value = 0.0;
                commentController.getUserComments();
                await commentController
                    .calculateUserPoint(controller.userlistoo[index].uid);
                Get.put(MapController()).getUserCurrentAdressFromDb(
                    controller.userlistoo[index].uid);
                Get.toNamed("/profileCustomerView", arguments: index);
              },
              child: Card(
                elevation: 2,
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.12,
                  child: Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 25,
                        foregroundImage: NetworkImage(
                          controller.userlistoo[index].profilePhotoPath == null
                              ? "https://www.nicepng.com/png/detail/136-1366211_group-of-10-guys-login-user-icon-png.png"
                              : controller.userlistoo[index].profilePhotoPath,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(controller.userlistoo[index].name +
                                    " " +
                                    controller.userlistoo[index].surname),
                                RatingBarIndicator(
                                  rating:
                                      controller.userlistoo[index].userPoint ==
                                                  null ||
                                              double.parse(controller
                                                      .userlistoo[index]
                                                      .userPoint) ==
                                                  0
                                          ? 0
                                          : double.parse(controller
                                              .userlistoo[index].userPoint),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 15.0,
                                  direction: Axis.horizontal,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.room_preferences_rounded,
                                              size: 15,
                                            ),
                                            Text(
                                              controller.userlistoo[index].job,
                                              style: cardTextStyle(),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_city,
                                              size: 15,
                                            ),
                                            Text(
                                              controller.userlistoo[index].city,
                                              style: cardTextStyle(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              size: 15,
                                            ),
                                            Text(
                                              controller.userlistoo[index]
                                                      .phoneNum ??
                                                  "-",
                                              style: cardTextStyle(),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.mail,
                                              size: 15,
                                            ),
                                            Text(
                                              controller
                                                  .userlistoo[index].email,
                                              style: cardTextStyle(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Expanded(child: Icon(Icons.star))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TextStyle cardTextStyle() {
    return TextStyle(fontSize: 11);
  }
}
