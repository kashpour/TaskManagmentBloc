import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String title;
  final String body;
  final String dateTime;

  TaskModel({required this.title, required this.body, required this.dateTime});

  factory TaskModel.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>; // Ensure it's a Map

    return TaskModel(
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      dateTime: data['dateTime'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'dateTime': dateTime,
    };
  }
}
