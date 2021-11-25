import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listify/constant/shared_preference_key.dart';
import 'package:listify/model/todo.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class TasksController extends GetxController {
  final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('tasks');
  CollectionReference get userTasksCollection => tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks');

  @override
  onReady() {
    super.onReady();
  }

  Future createNewTask(String title, description, dateTime, priority) async {
    try {
      DocumentReference documentReferencer = tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks').doc();
      await documentReferencer.set({
        "title": title,
        "description": description,
        "dateTime": dateTime != "" ? DateFormat('hh:mm aa MMM dd, yyyy').parse(dateTime).millisecondsSinceEpoch : DateTime.now().millisecondsSinceEpoch,
        "priority": priority == "" ? "Low" : priority,
        "isCompleted": false,
      });
    } catch (error, stackTrace) {
      print("createNewTask(): $error");
      print(stackTrace);
    }
  }

  updateTask(uid, title, description, dateTime, priority) async {
    await userTasksCollection.doc(uid).update({
      "title": title,
      "description": description,
      "dateTime": DateFormat('hh:mm aa MMM dd, yyyy').parse(dateTime).millisecondsSinceEpoch,
      "priority": priority,
    });
  }

  Future completeTask(uid) async {
    await userTasksCollection.doc(uid).update({"isCompleted": true});
  }

  Future undoCompleteTask(uid) async {
    await userTasksCollection.doc(uid).update({"isCompleted": false});
  }

  Future removeTodo(uid) async {
    await userTasksCollection.doc(uid).delete();
  }

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
}
