// To parse this JSON data, do
//
//     final chat = chatFromJson(jsonString);

import 'dart:convert';

import 'package:hizmet_bull_beta/models/chat_message.dart';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  Chat({this.sender1Uid, this.sender2Uid, this.messages});

  String sender1Uid;
  String sender2Uid;
  bool approveUser1;
  bool approveUser2;
  List<Message> messages = [];

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        sender1Uid: json["sender1UID"] == null ? null : json["sender1UID"],
        sender2Uid: json["sender2UID"] == null ? null : json["sender2UID"],
        messages: json["messages"] == null
            ? null
            : List<Message>.from(
                json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sender1UID": sender1Uid == null ? null : sender1Uid,
        "sender2UID": sender2Uid == null ? null : sender2Uid,
        "messages": messages == null
            ? null
            : List<dynamic>.from(messages.map((x) => x.toJson()))
      };
}
