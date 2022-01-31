import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

NotesModel notesModelFromJson(String str) =>
    NotesModel.fromJson(json.decode(str));

String notesModelToJson(NotesModel data) => json.encode(data.toJson());

class NotesModel {
  NotesModel({
    this.body = "",
    this.id = -1,
    this.color = 0x000000FF,
    this.date = "",
  });

  String body;
  int id;
  String date;
  int color;

  Color? get getColor {
    if (this.color != 0x000000FF) return Color(this.color);
    return null;
  }

  MaterialColor get createMaterialColor {
    Color temp = getColor ?? Colors.black;
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = temp.red, g = temp.green, b = temp.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(temp.value, swatch);
  }

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        body: json["body"] == null ? "" : json["body"],
        id: json["id"] == null ? -1 : json["id"],
        date: json["date"] == null ? "" : json["date"],
        color: json["color"] == null ? 0x000000FF : json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "date": date,
        "color": color,
      };

  Map<String, dynamic> toCreateJson() => {
        "body": body,
        "date": date,
        "color": color,
      };    

  Map<String, dynamic> toUpdateJson() => {
        "body": body,
      };

  Map<String, dynamic> toUpdateColor() => {
        "color": color,
      };
}
