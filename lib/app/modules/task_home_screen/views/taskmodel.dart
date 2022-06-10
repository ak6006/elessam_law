// To parse this JSON data, do
//
//     final tasktmodel = tasktmodelFromJson(jsonString);

import 'dart:convert';

List<Tasktmodel> tasktmodelFromJson(String str) =>
    List<Tasktmodel>.from(json.decode(str).map((x) => Tasktmodel.fromJson(x)));

String tasktmodelToJson(List<Tasktmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tasktmodel {
  Tasktmodel({
    required this.id,
    required this.name,
    required this.tagIds,
    required this.partnerId,
    required this.stageId,
    required this.description,
    required this.projectId,
    required this.userIds,
    required this.priority,
    required this.kanbanState,
    required this.kanbanStateLabel,
    required this.totalHoursSpent,
    required this.portalUserNames,
  });

  int id;
  String name;
  List<int> tagIds;
  List<dynamic> partnerId;
  List<dynamic> stageId;
  String description;
  List<dynamic> projectId;
  List<dynamic> userIds;
  String priority;
  String kanbanState;
  String kanbanStateLabel;
  dynamic totalHoursSpent;
  String portalUserNames;

  factory Tasktmodel.fromJson(Map<String, dynamic> json) => Tasktmodel(
        id: json["id"],
        name: json["name"],
        tagIds: List<int>.from(json["tag_ids"].map((x) => x)),
        partnerId: List<dynamic>.from(json["partner_id"].map((x) => x)),
        stageId: List<dynamic>.from(json["stage_id"].map((x) => x)),
        description: json["description"],
        projectId: List<dynamic>.from(json["project_id"].map((x) => x)),
        userIds: List<dynamic>.from(json["user_ids"].map((x) => x)),
        priority: json["priority"],
        kanbanState: json["kanban_state"],
        kanbanStateLabel: json["kanban_state_label"],
        totalHoursSpent: json["total_hours_spent"],
        portalUserNames: json["portal_user_names"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tag_ids": List<dynamic>.from(tagIds.map((x) => x)),
        "partner_id": List<dynamic>.from(partnerId.map((x) => x)),
        "stage_id": List<dynamic>.from(stageId.map((x) => x)),
        "description": description,
        "project_id": List<dynamic>.from(projectId.map((x) => x)),
        "user_ids": List<dynamic>.from(userIds.map((x) => x)),
        "priority": priority,
        "kanban_state": kanbanState,
        "kanban_state_label": kanbanStateLabel,
        "total_hours_spent": totalHoursSpent,
        "portal_user_names": portalUserNames,
      };
}
