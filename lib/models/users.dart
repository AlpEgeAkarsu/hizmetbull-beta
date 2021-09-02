// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:hizmet_bull_beta/models/evaluation.dart';

AppUser userFromJson(String str) => AppUser.fromJson(json.decode(str));

String userToJson(AppUser data) => json.encode(data.toJson());

class AppUser {
  AppUser(
      {this.city,
      this.description,
      this.email,
      this.job,
      this.licensedegree,
      this.location,
      this.name,
      this.phoneNum,
      this.surname,
      this.jobcity,
      this.uid,
      this.userType,
      this.profilePhotoPath,
      this.userPoint});

  String city;
  String description;
  String email;
  String job;
  String licensedegree;
  Location location;
  String name;
  String phoneNum;
  String surname;
  String uid;
  int userType;
  String profilePhotoPath;
  String jobcity;
  String userPoint;
  // List<UserComment> comments = []; // kaldırabilirsni

  factory AppUser.fromJson(Map<dynamic, dynamic> json) => AppUser(
      city: json["city"] == null ? null : json["city"],
      description: json["description"] == null ? null : json["description"],
      email: json["email"] == null ? null : json["email"],
      job: json["job"] == null ? null : json["job"],
      licensedegree:
          json["licensedegree"] == null ? null : json["licensedegree"],
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      name: json["name"] == null ? null : json["name"],
      phoneNum: json["phoneNum"] == null ? null : json["phoneNum"],
      surname: json["surname"] == null ? null : json["surname"],
      uid: json["uid"] == null ? null : json["uid"],
      userType: json["userType"] == null ? null : json["userType"],
      userPoint: json["userPoint"] == null ? null : json["userPoint"],
      profilePhotoPath:
          json["profilePhotoPath"] == null ? null : json["profilePhotoPath"],
      jobcity: json["jobcity"] == null ? null : json["jobcity"]);

  Map<String, dynamic> toJson() => {
        "city": city == null ? null : city,
        "description": description == null ? null : description,
        "email": email == null ? null : email,
        "job": job == null ? null : job,
        "licensedegree": licensedegree == null ? null : licensedegree,
        "location": location == null ? null : location.toJson(),
        // "comments":
        //     List<dynamic>.from(comments.map((x) => x.toJson())), // ask some1
        "name": name == null ? null : name,
        "phoneNum": phoneNum == null ? null : phoneNum,
        "surname": surname == null ? null : surname,
        "uid": uid == null ? null : uid,
        "userType": userType == null ? null : userType,
        "userPoint": userPoint == null ? null : userPoint,
        "jobcity": jobcity == null ? null : jobcity,
        "profilePhotoPath": profilePhotoPath == null ? null : profilePhotoPath
      };
}

class Location {
  Location({
    this.lang,
    this.lat,
  });

  String lang;
  String lat;

  factory Location.fromJson(Map<dynamic, dynamic> json) => Location(
        lang: json["lang"] == null ? null : json["lang"],
        lat: json["lat"] == null ? null : json["lat"],
      );

  Map<String, dynamic> toJson() => {
        "lang": lang == null ? null : lang,
        "lat": lat == null ? null : lat,
      };
}
