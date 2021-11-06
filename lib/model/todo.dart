import 'package:intl/intl.dart';

class Todo {
  final String title;
  final dateTime;
  final String priority;
  final bool isCompleted;
  final uid;
  Todo({this.title, this.dateTime, this.priority, this.isCompleted, this.uid});

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        title: json["title"],
        dateTime: DateFormat("MMM dd, yyyy hh:mm aa").format(DateTime.fromMillisecondsSinceEpoch(json["dateTime"])),
        priority: json["message"],
        isCompleted: json["isCompleted"],
        uid: json["id"],
      );
}
