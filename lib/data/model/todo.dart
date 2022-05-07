import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Todo {
  final String title;
  final String description;
  final String dateTime;
  final List<SubTask> subTask;
  final String priority;
  final bool isCompleted;
  final uid;

  Todo({
    this.title,
    this.description,
    this.dateTime,
    this.subTask,
    this.priority,
    this.isCompleted,
    this.uid,
  });

  Todo copyWith({
    String title,
    String description,
    String dateTime,
    List<SubTask> subTask,
    String priority,
    bool isCompleted,
    uid,
  }) =>
      Todo(
        title: title ?? this.title,
        description: description ?? this.description,
        dateTime: dateTime ?? this.dateTime,
        subTask: subTask ?? this.subTask,
        priority: priority ?? this.priority,
        isCompleted: isCompleted ?? this.isCompleted,
        uid: uid ?? this.uid,
      );

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        title: json["title"],
        description: json["description"],
        dateTime: DateFormat("MMM dd, yyyy hh:mm aa").format(DateTime.fromMillisecondsSinceEpoch(json["dateTime"])),
        subTask: List<SubTask>.from(json["subTask"].map((task) => SubTask.fromJson(task))),
        priority: json["message"],
        isCompleted: json["isCompleted"],
        uid: json["id"],
      );

  Todo.fromMap(Map<String, dynamic> map, id)
      : title = map["title"],
        description = map["description"],
        dateTime = DateFormat('hh:mm aa MMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(map["dateTime"])),
        subTask = (map["subTask"] as List<dynamic>).map((e) => SubTask.fromMap(e)).toList(),
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
