class TaskModel {
  final String title;
  final String body;
  final DateTime dateTime;

  TaskModel({required this.title, required this.body, required this.dateTime});

  factory TaskModel.fromJson(Map<String, dynamic> jsonMap) {
    return TaskModel(
      title: jsonMap['title'],
      body: jsonMap['body'],
      dateTime: jsonMap['dateTime'],
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
