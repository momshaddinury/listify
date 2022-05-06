import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/data/repository/task/task_repository.dart';

import '../../../data/model/todo.dart';

final tasksProvider = Provider((ref) => _TasksController(ref: ref));

final taskProvider = Provider<Todo>((ref) => throw UnimplementedError());

final pendingTasksProvider = StreamProvider<List<Todo>>((ref) {
  return ref.watch(taskRepositoryProvider).pendingTasks();
});

final completedTasksProvider = StreamProvider<List<Todo>>((ref) {
  return ref.watch(taskRepositoryProvider).completedTasks();
});

class _TasksController {
  final Ref ref;
  var _repository;
  _TasksController({this.ref}) {
    _repository = ref.read(taskRepositoryProvider);
  }

  void completeTask(uid) {
    _repository.completeTask(uid);
  }

  void undoCompleteTask(uid) {
    _repository.undoCompleteTask(uid);
  }

  void removeTodo(uid) {
    _repository.removeTodo(uid);
  }
}
