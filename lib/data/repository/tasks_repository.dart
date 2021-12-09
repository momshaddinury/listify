import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listify/data/constant/shared_preference_key.dart';
import 'package:listify/data/model/todo.dart';
import 'package:intl/intl.dart';
import 'package:listify/main.dart';

class TasksRepository {
  final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('tasks');

  CollectionReference get userTasksCollection => tasksCollection.doc(box.read(USER_UID)).collection('usertasks');

  Stream<List<Todo>> pendingTasks() {
    Query userTasksQuery = userTasksCollection.where("isCompleted", isEqualTo: false).orderBy("dateTime", descending: true);
    return userTasksQuery.snapshots().map(todoFromFirestore);
  }

  Stream<List<Todo>> completedTasks() {
    Query userTasksQuery = userTasksCollection.where("isCompleted", isEqualTo: true).orderBy("dateTime", descending: true);
    return userTasksQuery.snapshots().map(todoFromFirestore);
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

  Future<void> createNewTask(String title, description, dateTime, priority) async {
    try {
      DocumentReference documentReferencer = tasksCollection.doc(box.read(USER_UID)).collection('usertasks').doc();
      await documentReferencer.set({
        "title": title,
        "description": description,
        "dateTime":
            dateTime != "" ? DateFormat('hh:mm aa MMM dd, yyyy').parse(dateTime).millisecondsSinceEpoch : DateTime.now().millisecondsSinceEpoch,
        "priority": priority == "" ? "Low" : priority,
        "isCompleted": false,
      });
    } catch (error, stackTrace) {
      print("createNewTask(): $error");
      print(stackTrace);
    }
  }

  Future<void> updateTask(uid, title, description, dateTime, priority) async {
    await userTasksCollection.doc(uid).update({
      "title": title,
      "description": description,
      "dateTime": DateFormat('hh:mm aa MMM dd, yyyy').parse(dateTime).millisecondsSinceEpoch,
      "priority": priority,
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
