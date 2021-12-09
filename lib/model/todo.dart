import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Todo {
  final String title;
  final String description;
  final dateTime;
  final List<SubTask> subtask;
  final String priority;
  final bool isCompleted;
  final uid;

  Todo({
    this.title,
    this.description,
    this.dateTime,
    this.subtask,
    this.priority,
    this.isCompleted,
    this.uid,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        title: json["title"],
        description: json["description"],
        dateTime: DateFormat("MMM dd, yyyy hh:mm aa").format(DateTime.fromMillisecondsSinceEpoch(json["dateTime"])),
        subtask: List<SubTask>.from(json["subTask"].map((task) => SubTask.fromJson(task))),
        priority: json["message"],
        isCompleted: json["isCompleted"],
        uid: json["id"],
      );
}

class SubTask {
  final String title;
  final bool isCompleted;
  final uid;

  SubTask({this.title, this.isCompleted, this.uid});

  factory SubTask.fromJson(Map<String, dynamic> json) => SubTask(
        title: json["title"],
        isCompleted: json["isCompleted"],
        uid: json["id"],
      );
}

List<Todo> todoFromFirestore(QuerySnapshot snapshot) {
  if (snapshot != null) {
    return snapshot.docs.map((e) {
      return Todo(
        isCompleted: e["isCompleted"],
        title: e["title"],
        description: e["description"],
        dateTime: DateFormat('hh:mm aa MMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(e["dateTime"])),
        priority: e["priority"],
        uid: e.id,
      );
    }).toList();
  } else {
    return null;
  }
}
