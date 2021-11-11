import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/constant/shared_preference_key.dart';
import 'package:listify/model/todo.dart';
import 'package:nb_utils/nb_utils.dart';
import 'tasks_state.dart';
import 'package:intl/intl.dart';

final tasksProvider = StateNotifierProvider((ref) => TasksController(ref: ref));

class TasksController extends StateNotifier<TasksState> {
  final Ref ref;

  TasksController({this.ref}) : super(TasksInitialState());

  final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('tasks');
  CollectionReference get userTasksCollection => tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks');

  Future createNewTask(String title, description, dateTime, priority) async {
    state = TasksLoadingState();
    try {
      DocumentReference documentReferencer = tasksCollection.doc(getStringAsync(USER_UID)).collection('usertasks').doc();
      await documentReferencer.set({
        "title": title,
        "description": description,
        "dateTime": dateTime != "" ? DateFormat("MMM dd, yyyy hh:mm aa").parse(dateTime).millisecondsSinceEpoch : DateTime.now().millisecondsSinceEpoch,
        "priority": priority == "" ? "Low" : priority,
        "isCompleted": false,
      });
    } catch (error, stackTrace) {
      print("createNewTask(): $error");
      print(stackTrace);
      state = TasksErrorState();
    }
  }

  updateTask(uid, title, description, dateTime, priority) async {
    await userTasksCollection.doc(uid).update({
      "title": title,
      "description": description,
      "dateTime": DateFormat("MMM dd, yyyy hh:mm aa").parse(dateTime).millisecondsSinceEpoch,
      "priority": priority,
    });
  }

  Future completeTask(uid) async {
    await userTasksCollection.doc(uid).update({"isCompleted": true});
  }

  Future undoCompleteTask(uid) async {
    await userTasksCollection.doc(uid).update({"isCompleted": false});
  }

  Stream<List<Todo>> fetchPendingTasks() {
    Query userTasksQuery = userTasksCollection.where("isCompleted", isEqualTo: false).orderBy("dateTime", descending: true);
    return userTasksQuery.snapshots().map(todoFromFirestore);
  }

  Stream<List<Todo>> fetchCompletedTasks() {
    Query userTasksQuery = userTasksCollection.where("isCompleted", isEqualTo: true).orderBy("dateTime", descending: true);
    return userTasksQuery.snapshots().map(todoFromFirestore);
  }

  Future removeTodo(uid) async {
    await userTasksCollection.doc(uid).delete();
  }

  List<Todo> todoFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Todo(
          isCompleted: e["isCompleted"],
          title: e["title"],
          description: e["description"],
          dateTime: DateFormat('MMM dd, yyyy hh:mm aa').format(DateTime.fromMillisecondsSinceEpoch(e["dateTime"])),
          priority: e["priority"],
          uid: e.id,
        );
      }).toList();
    } else {
      return null;
    }
  }
}
