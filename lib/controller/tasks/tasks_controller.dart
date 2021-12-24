import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/constant/shared_preference_key.dart';
import 'package:listify/controller/tasks/tasks_provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';

class TasksController {
  final Ref ref;

  TasksController({this.ref});

  final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('tasks');

  CollectionReference get userTasksCollection => tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks');

  Future<void> createNewTask(String title, description, dateTime, priority) async {
    try {
      DocumentReference documentReferencer = tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks').doc();
      await documentReferencer.set({
        "title": title,
        "description": description,
        "dateTime":
            dateTime != "" ? DateFormat('hh:mm aa MMM dd, yyyy').parse(dateTime).millisecondsSinceEpoch : DateTime.now().millisecondsSinceEpoch,
        "priority": priority == "" ? "Low" : priority,
        "subTask": [],
        "isCompleted": false,
      });
    } catch (error, stackTrace) {
      print("createNewTask(): $error");
      print(stackTrace);
    }
  }

  Future<void> updateTask(uid, {String title, String description, String dateTime, String priority}) async {
    await userTasksCollection.doc(uid).update({
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (dateTime != null) "dateTime": DateFormat('hh:mm aa MMM dd, yyyy').parse(dateTime).millisecondsSinceEpoch,
      if (priority != null) "priority": priority,
    });
  }

  Future<void> updateSubTask() async {
    List<Map<String, dynamic>> subTaskMappedList = [];

    ref.read(taskDetailsProvider).subTask.forEach((subTask) {
      subTaskMappedList.add(subTask.toMap());
    });
    await userTasksCollection.doc(ref.read(taskDetailsProvider).uid).update({
      "subTask": subTaskMappedList,
    });
  }

  Future<void> completeTask(uid) async {
    await userTasksCollection.doc(uid).update({"isCompleted": true});
  }

  Future<void> undoCompleteTask(uid) async {
    await userTasksCollection.doc(uid).update({"isCompleted": false});
  }

  Future<void> removeTodo(uid) async {
    await userTasksCollection.doc(uid).delete();
  }
}
