import 'dart:convert';

import 'package:flutter/material.dart';

class NoteModel {
  String? title;
  String? description;
  String? date;

  NoteModel({
    required this.title,
    required this.description,
    required this.date,
  });

  NoteModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    date = json['date'];
  }

  static Map<String, dynamic> toMap(NoteModel noteModel) => {
        'title': noteModel.title,
        'description': noteModel.description,
        'date': noteModel.date.toString(),
      };

  static String encode(List<NoteModel> notes) => json.encode(
        notes
            .map<Map<String, dynamic>>((note) => NoteModel.toMap(note))
            .toList(),
      );

  static List<NoteModel> decode(String notes) =>
      (json.decode(notes) as List<dynamic>)
          .map<NoteModel>((item) => NoteModel.fromJson(item))
          .toList();
}
