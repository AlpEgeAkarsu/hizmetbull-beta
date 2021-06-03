import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/comment_controller.dart';

class ResultsView extends GetWidget<FirebaseAuthController> {
  CommentController commentController = Get.put(CommentController());
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
          commentController.currentPageUID.value =
              controller.userlistoo[index].uid;

          commentController.getOneComment();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                print(index.toString());
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
                        foregroundImage: AssetImage(
                          "assets/images/exampleAvatar.png",
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
                                Obx(() => RatingBarIndicator(
                                      rating: commentController
                                                  .userTotalPoint !=
                                              0.obs
                                          ? commentController.userTotalPoint /
                                              commentController.comments.length
                                          : 0,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 15.0,
                                      direction: Axis.horizontal,
                                    )),
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
                                              "05322230525",
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
