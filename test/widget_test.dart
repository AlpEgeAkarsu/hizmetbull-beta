// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hizmet_bull_beta/core/controllers/chatroomstore_controller.dart';

void main() {
  test("Read File", () {
    var myFile = File("assets/texts/jobs.txt");
    List<String> test = <String>[];
    myFile.readAsString().then((String value) {
      for (var item in test) {
        test.add(value);
        print(item);
      }
    });
  });

  test("Check User Approve Method", () {
    Get.put(ChatRoomStoreController()).checkIfUsersApprovedEachOther(
        "lzsmauL8tkevfxD0aNyphkDz5VI3_5CHuQeXC4XYu74eM3LRMGVZRdZX2");
  });
}
