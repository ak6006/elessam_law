// To parse this JSON data, do
//
//     final projectmodel = projectmodelFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<Projectmodel> projectmodelFromJson(String str) => List<Projectmodel>.from(
    json.decode(str).map((x) => Projectmodel.fromJson(x)));

String projectmodelToJson(List<Projectmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Projectmodel {
  Projectmodel({
    required this.id,
    required this.name,
    required this.tagIds,
    required this.partnerId,
    required this.userId,
    required this.description,
    required this.taskCount,
    required this.tasks,
    required this.taskCountWithSubtasks,
  });

  int id;
  String name;
  List<int> tagIds;
  List<dynamic> partnerId;
  List<dynamic> userId;
  String description;
  int taskCount;
  List<int> tasks;
  int taskCountWithSubtasks;

  factory Projectmodel.fromJson(Map<String, dynamic> json) => Projectmodel(
        id: json["id"],
        name: json["name"],
        tagIds: List<int>.from(json["tag_ids"].map((x) => x)),
        partnerId: List<dynamic>.from(json["partner_id"].map((x) => x)),
        userId: List<dynamic>.from(json["user_id"].map((x) => x)),
        description: json["description"],
        taskCount: json["task_count"],
        tasks: List<int>.from(json["tasks"].map((x) => x)),
        taskCountWithSubtasks: json["task_count_with_subtasks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tag_ids": List<dynamic>.from(tagIds.map((x) => x)),
        "partner_id": List<dynamic>.from(partnerId.map((x) => x)),
        "user_id": List<dynamic>.from(userId.map((x) => x)),
        "description": description,
        "task_count": taskCount,
        "tasks": List<dynamic>.from(tasks.map((x) => x)),
        "task_count_with_subtasks": taskCountWithSubtasks,
      };
}
