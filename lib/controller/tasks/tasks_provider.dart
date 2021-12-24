import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/model/todo.dart';

import 'tasks_controller.dart';

final tasksProvider = Provider((ref) => TasksController(ref: ref));

final taskProvider = Provider<Todo>((ref) => throw UnimplementedError());

final taskDetailsProvider = StateProvider<Todo>((ref) {
  return Todo();
});

final pendingTasksProvider = StreamProvider<List<Todo>>((ref) {
  Query userTasksQuery = ref.watch(tasksProvider).userTasksCollection.where("isCompleted", isEqualTo: false).orderBy("dateTime", descending: true);
  return userTasksQuery.snapshots().map(parseSnapshot);
});

final completedTasksProvider = StreamProvider<List<Todo>>((ref) {
  Query userTasksQuery = ref.watch(tasksProvider).userTasksCollection.where("isCompleted", isEqualTo: true).orderBy("dateTime", descending: true);
  return userTasksQuery.snapshots().map(parseSnapshot);
});
