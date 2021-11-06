import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/constant/shared_preference_key.dart';
import 'package:listify/model/todo.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';

import 'tasks_state.dart';

final tasksProvider = StateNotifierProvider<TasksController>(
  (ref) => TasksController(ref: ref),
);

class TasksController extends StateNotifier<TasksState> {
  final ProviderReference ref;
  TasksController({this.ref}) : super(TasksInitialState());

  CollectionReference tasksCollection = FirebaseFirestore.instance.collection('tasks');

  Future createNewTask(String title, dateTime, priority) async {
    state = TasksLoadingState();
    try {
      DocumentReference documentReferencer = tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks').doc();
      await documentReferencer.set({
        "title": title,
        "dateTime": dateTime != "" ? dateTime : DateFormat('MMM dd, yyyy hh:mm:aa').format(DateTime.now()),
        "priority": priority == "" ? "Low" : priority,
        "isCompleted": false,
      });
    } catch (error, stackTrace) {
      print("createNewTask(): $error");
      print(stackTrace);
      state = TasksErrorState();
    }
  }

  updateTask(uid, title, dateTime, priority) async {
    CollectionReference userTasksCollection = tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks');
    await userTasksCollection.doc(uid).update({
      "title": title,
      "dateTime": dateTime,
      "priority": priority,
    });
  }

  Future completeTask(uid) async {
    CollectionReference userTasksCollection = tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks');
    await userTasksCollection.doc(uid).update({"isCompleted": true});
  }

  Future undoCompleteTask(uid) async {
    CollectionReference userTasksCollection = tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks');
    await userTasksCollection.doc(uid).update({"isCompleted": false});
  }

  Stream<List<Todo>> fetchPendingTasks() {
    CollectionReference userTasksCollection = tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks');
    Query userTasksQuery = userTasksCollection.where("isCompleted", isEqualTo: false);
    return userTasksQuery.snapshots().map(todoFromFirestore);
  }

  Stream<List<Todo>> fetchCompletedTasks() {
    CollectionReference userTasksCollection = tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks');
    Query userTasksQuery = userTasksCollection.where("isCompleted", isEqualTo: true);
    return userTasksQuery.snapshots().map(todoFromFirestore);
  }

  Future removeTodo(uid) async {
    CollectionReference userTasksCollection = tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks');
    await userTasksCollection.doc(uid).delete();
  }

  List<Todo> todoFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Todo(
          isCompleted: e["isCompleted"],
          title: e["title"],
          dateTime: e["dateTime"],
          priority: e["priority"],
          uid: e.id,
        );
      }).toList();
    } else {
      return null;
    }
  }
}
