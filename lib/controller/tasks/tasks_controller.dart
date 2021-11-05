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

  Future completeTask(uid) async {
    CollectionReference userTasksCollection = tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks');
    await userTasksCollection.doc(uid).update({"isCompleted": true});
  }

  Future undoCompleteTask(uid) async {
    CollectionReference userTasksCollection = tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks');
    await userTasksCollection.doc(uid).update({"isCompleted": false});
  }

  Stream<List<Todo>> fetchTasks() {
    CollectionReference userTasksCollection = tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks');
    return userTasksCollection.snapshots().map(todoFromFirestore);
  }

  Future removeTodo(uid) async {
    CollectionReference userTasksCollection = tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks');
    await userTasksCollection.doc(uid).delete();
  }

  List<Todo> todoFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs
          .map((e) {
            return Todo(
              isCompleted: e["isCompleted"],
              title: e["title"],
              dateTime: e["dateTime"],
              priority: e["priority"],
              uid: e.id,
            );
          })
          .toList()
          .reversed
          .toList();
    } else {
      return null;
    }
  }
}
