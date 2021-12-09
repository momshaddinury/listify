import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listify/data/constant/shared_preference_key.dart';
import 'package:listify/data/repository/tasks_repository.dart';
import 'package:listify/main.dart';
import 'package:listify/data/model/todo.dart';
import 'package:get/get.dart';

class TasksViewModel extends GetxController {
  final TasksRepository _tasksRepository = TasksRepository();

  final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('tasks');

  CollectionReference get userTasksCollection => tasksCollection.doc(box.read(USER_UID)).collection('usertasks');

  Future<void> createNewTask(String title, description, dateTime, priority) => _tasksRepository.createNewTask(title, description, dateTime, priority);

  Future<void> updateTask(uid, title, description, dateTime, priority) => _tasksRepository.updateTask(uid, title, description, dateTime, priority);

  Future<void> completeTask(uid) => _tasksRepository.completeTask(uid);

  Future<void> undoCompleteTask(uid) => _tasksRepository.undoCompleteTask(uid);

  Future<void> removeTodo(uid) => _tasksRepository.removeTodo(uid);

  Stream<List<Todo>> pendingTasks() => _tasksRepository.pendingTasks();

  Stream<List<Todo>> completedTasks() => _tasksRepository.completedTasks();
}
