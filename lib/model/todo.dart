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

  Todo.fromMap(Map<String, dynamic> map, id)
      : title = map["title"],
        description = map["description"],
        dateTime = DateFormat('hh:mm aa MMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(map["dateTime"])),
        subtask = (map["subTask"] as List<dynamic>).map((e) => SubTask.fromMap(e)).toList(),
        priority = map["priority"],
        isCompleted = map["isCompleted"],
        uid = id;
}

class SubTask {
  String title;
  bool isCompleted;

  SubTask({
    this.title,
    this.isCompleted = false,
  });

  factory SubTask.fromJson(Map<String, dynamic> json) => SubTask(
        title: json["title"],
        isCompleted: json["isCompleted"],
      );

  Map<String, dynamic> toMap() => {
        "title": this.title,
        "isCompleted": this.isCompleted,
      };

  SubTask.fromMap(Map<String, dynamic> map)
      : title = map["title"],
        isCompleted = map["isCompleted"];
}

List<Todo> parseSnapshot(QuerySnapshot snapshot) => snapshot.docs.map((e) {
      return Todo.fromMap(e.data(), e.id);
    }).toList();
