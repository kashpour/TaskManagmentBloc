import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id = '';
  String title = '';
  String description = '';
  String dateTime = '';

  TaskModel(
      {required this.title, required this.description, required this.dateTime});

  TaskModel.fromJson(DocumentSnapshot doc, String documentId) {
    final data = doc.data() as Map<String, dynamic>;
    id = documentId;
    title = data['title'] ?? '';
    description = data['description'] ?? '';
    dateTime = data['dateTime'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime,
    };
  }
}
