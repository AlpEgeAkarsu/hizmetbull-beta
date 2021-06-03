// To parse this JSON data, do
//
//     final userComment = userCommentFromJson(jsonString);

import 'dart:convert';

UserComment userCommentFromJson(String str) =>
    UserComment.fromJson(json.decode(str));

String userCommentToJson(UserComment data) => json.encode(data.toJson());

class UserComment {
  UserComment({
    this.commentContent,
    this.commentDate,
    this.commentOwner,
    this.commentPoint,
    this.commentator,
  });

  String commentContent;
  String commentDate;
  String commentOwner;
  int commentPoint;
  String commentator;

  factory UserComment.fromJson(Map<dynamic, dynamic> json) => UserComment(
        commentContent:
            json["commentContent"] == null ? null : json["commentContent"],
        commentDate: json["commentDate"] == null ? null : json["commentDate"],
        commentOwner:
            json["commentOwner"] == null ? null : json["commentOwner"],
        commentPoint:
            json["commentPoint"] == null ? null : json["commentPoint"],
        commentator: json["commentator"] == null ? null : json["commentator"],
      );

  Map<dynamic, dynamic> toJson() => {
        "commentContent": commentContent == null ? null : commentContent,
        "commentDate": commentDate == null ? null : commentDate,
        "commentOwner": commentOwner == null ? null : commentOwner,
        "commentPoint": commentPoint == null ? null : commentPoint,
        "commentator": commentator == null ? null : commentator,
      };
}
