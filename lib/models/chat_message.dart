// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    this.content,
    this.messageDate,
    this.sentBy,
  });

  String content;
  String messageDate;
  String sentBy;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        content: json["content"] == null ? null : json["content"],
        messageDate: json["messageDate"] == null ? null : json["messageDate"],
        sentBy: json["sentBy"] == null ? null : json["sentBy"],
      );

  Map<String, dynamic> toJson() => {
        "content": content == null ? null : content,
        "messageDate": messageDate == null ? null : messageDate,
        "sentBy": sentBy == null ? null : sentBy,
      };
}
