// To parse this JSON data, do
//
//     final ticketmessage = ticketmessageFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Ticketmessage ticketmessageFromJson(String str) =>
    Ticketmessage.fromJson(json.decode(str));

String ticketmessageToJson(Ticketmessage data) => json.encode(data.toJson());

class Ticketmessage {
  Ticketmessage({
    required this.messages,
    required this.messageCount,
  });

  List<Message> messages;
  int messageCount;

  factory Ticketmessage.fromJson(Map<String, dynamic> json) => Ticketmessage(
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
        messageCount: json["message_count"],
      );

  Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "message_count": messageCount,
      };
}

class Message {
  Message({
    required this.id,
    required this.body,
    required this.date,
    required this.authorId,
    required this.emailFrom,
    required this.messageType,
    required this.subtypeId,
    required this.isInternal,
    required this.subject,
    required this.model,
    required this.resId,
    required this.recordName,
    required this.notifications,
    required this.attachmentIds,
    required this.trackingValueIds,
    required this.messageReactionGroups,
  });

  int id;
  String body;
  DateTime date;
  List<dynamic> authorId;
  String emailFrom;
  String messageType;
  List<dynamic> subtypeId;
  bool isInternal;
  dynamic subject;
  String model;
  int resId;
  String recordName;
  List<Notification> notifications;
  List<dynamic> attachmentIds;
  List<dynamic> trackingValueIds;
  List<List<dynamic>> messageReactionGroups;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        body: json["body"],
        date: DateTime.parse(json["date"]),
        authorId: List<dynamic>.from(json["author_id"].map((x) => x)),
        emailFrom: json["email_from"],
        messageType: json["message_type"],
        subtypeId: List<dynamic>.from(json["subtype_id"].map((x) => x)),
        isInternal: json["is_internal"],
        subject: json["subject"],
        model: json["model"],
        resId: json["res_id"],
        recordName: json["record_name"],
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
        attachmentIds: List<dynamic>.from(json["attachment_ids"].map((x) => x)),
        trackingValueIds:
            List<dynamic>.from(json["tracking_value_ids"].map((x) => x)),
        messageReactionGroups: List<List<dynamic>>.from(
            json["messageReactionGroups"]
                .map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "date": date.toIso8601String(),
        "author_id": List<dynamic>.from(authorId.map((x) => x)),
        "email_from": emailFrom,
        "message_type": messageType,
        "subtype_id": List<dynamic>.from(subtypeId.map((x) => x)),
        "is_internal": isInternal,
        "subject": subject,
        "model": model,
        "res_id": resId,
        "record_name": recordName,
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
        "attachment_ids": List<dynamic>.from(attachmentIds.map((x) => x)),
        "tracking_value_ids":
            List<dynamic>.from(trackingValueIds.map((x) => x)),
        "messageReactionGroups": List<dynamic>.from(messageReactionGroups
            .map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class Notification {
  Notification({
    required this.id,
    required this.notificationType,
    required this.notificationStatus,
    required this.failureType,
    required this.resPartnerId,
  });

  int id;
  String notificationType;
  String notificationStatus;
  bool failureType;
  List<dynamic> resPartnerId;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        notificationType: json["notification_type"],
        notificationStatus: json["notification_status"],
        failureType: json["failure_type"],
        resPartnerId: List<dynamic>.from(json["res_partner_id"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "notification_type": notificationType,
        "notification_status": notificationStatus,
        "failure_type": failureType,
        "res_partner_id": List<dynamic>.from(resPartnerId.map((x) => x)),
      };
}









// // To parse this JSON data, do
// //
// //     final tasktmodel = tasktmodelFromJson(jsonString);

// // import 'package:meta/meta.dart';
// import 'dart:convert';

// List<Ticketmessage> ticketmessageFromJson(String str) =>
//     List<Ticketmessage>.from(
//         json.decode(str).map((x) => Ticketmessage.fromJson(x)));

// String tasktmodelToJson(List<Ticketmessage> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Ticketmessage {
//   Ticketmessage({
//     required this.id,
//     required this.body,
//     required this.emailFrom,
//     required this.replyTo,
//     required this.subject,
//     required this.authorId,
//     required this.createUid,
//     required this.messageId,
//     required this.resId,
//     required this.date,
//     required this.messageType,
//     required this.subtypeId,
//     required this.model,
//     required this.notifiedPartnerIds,
//     required this.notificationIds,
//     required this.parentId,
//   });

//   int id;
//   String body;
//   String emailFrom;
//   String replyTo;
//   dynamic subject;
//   List<dynamic> authorId;
//   List<dynamic> createUid;
//   String messageId;
//   int resId;
//   DateTime date;
//   String messageType;
//   List<dynamic> subtypeId;
//   String model;
//   List<dynamic> notifiedPartnerIds;
//   List<int> notificationIds;
//   List<dynamic> parentId;

//   factory Ticketmessage.fromJson(Map<String, dynamic> json) => Ticketmessage(
//         id: json["id"],
//         body: json["body"],
//         emailFrom: json["email_from"],
//         replyTo: json["reply_to"] == false ? "" : json["reply_to"],
//         subject: json["subject"],
//         authorId: List<dynamic>.from(json["author_id"].map((x) => x)),
//         createUid: List<dynamic>.from(json["create_uid"].map((x) => x)),
//         messageId: json["message_id"],
//         resId: json["res_id"],
//         date: DateTime.parse(json["date"]),
//         messageType: json["message_type"],
//         subtypeId: List<dynamic>.from(json["subtype_id"].map((x) => x)),
//         model: json["model"],
//         notifiedPartnerIds:
//             List<dynamic>.from(json["notified_partner_ids"].map((x) => x)),
//         notificationIds: List<int>.from(json["notification_ids"].map((x) => x)),
//         parentId: json["parent_id"] == false
//             ? []
//             : List<dynamic>.from(json["parent_id"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "body": body,
//         "email_from": emailFrom,
//         "reply_to": replyTo,
//         "subject": subject,
//         "author_id": List<dynamic>.from(authorId.map((x) => x)),
//         "create_uid": List<dynamic>.from(createUid.map((x) => x)),
//         "message_id": messageId,
//         "res_id": resId,
//         "date": date.toIso8601String(),
//         "message_type": messageType,
//         "subtype_id": List<dynamic>.from(subtypeId.map((x) => x)),
//         "model": model,
//         "notified_partner_ids":
//             List<dynamic>.from(notifiedPartnerIds.map((x) => x)),
//         "notification_ids": List<dynamic>.from(notificationIds.map((x) => x)),
//         "parent_id": List<dynamic>.from(parentId.map((x) => x)),
//       };
// }
