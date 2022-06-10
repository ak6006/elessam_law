// To parse this JSON data, do
//
//     final ticketModel = ticketModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<TicketModel> ticketModelFromJson(String str) => List<TicketModel>.from(json.decode(str).map((x) => TicketModel.fromJson(x)));

String ticketModelToJson(List<TicketModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TicketModel {
    TicketModel({
        required this.id,
      required this.name,
        required this.stageId,
        required this.partnerId,
        required this.categoryId,
        required this.description,
      required this.createDate,
        required this.websiteMessageIds,
    });

    final int id;
    final String name;
    final List<dynamic> stageId;
    final List<dynamic> partnerId;
    final List<dynamic> categoryId;
    final String description;
    final DateTime createDate;
    final List<int> websiteMessageIds;

    factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        id: json["id"],
        name: json["name"],
        stageId: List<dynamic>.from(json["stage_id"].map((x) => x)),
        partnerId: List<dynamic>.from(json["partner_id"].map((x) => x)),
        categoryId: List<dynamic>.from(json["category_id"].map((x) => x)),
        description: json["description"],
        createDate: DateTime.parse(json["create_date"]),
        websiteMessageIds: List<int>.from(json["website_message_ids"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "stage_id": List<dynamic>.from(stageId.map((x) => x)),
        "partner_id": List<dynamic>.from(partnerId.map((x) => x)),
        "category_id": List<dynamic>.from(categoryId.map((x) => x)),
        "description": description,
        "create_date": createDate.toIso8601String(),
        "website_message_ids": List<dynamic>.from(websiteMessageIds.map((x) => x)),
    };
}
