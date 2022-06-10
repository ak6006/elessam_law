// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    required this.notification,
    required this.data,
  });

  Notification notification;
  Data data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notification: Notification.fromJson(json["notification"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "notification": notification.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.clickAction,
    required this.model,
    required this.resId,
    required this.taskname,
    required this.projectname,
    required this.projectid,
  });

  String clickAction;
  String model;
  dynamic resId;
  String taskname;
  String projectname;
  dynamic projectid;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        clickAction: json["click_action"],
        model: json["model"],
        resId: json["resId"],
        taskname: json["taskname"],
        projectname: json["projectname"],
        projectid: json["projectid"],
      );

  Map<String, dynamic> toJson() => {
        "click_action": clickAction,
        "model": model,
        "resId": resId,
        "taskname": taskname,
        "projectname": projectname,
        "projectid": projectid,
      };
}

class Notification {
  Notification({
    required this.body,
    required this.title,
  });

  String body;
  String title;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        body: json["body"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "title": title,
      };
}
