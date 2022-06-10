// To parse this JSON data, do
//
//     final ticketCateg = ticketCategFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<TicketCateg> ticketCategFromJson(String str) => List<TicketCateg>.from(
    json.decode(str).map((x) => TicketCateg.fromJson(x)));

String ticketCategToJson(List<TicketCateg> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TicketCateg {
  TicketCateg({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory TicketCateg.fromJson(Map<String, dynamic> json) => TicketCateg(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
