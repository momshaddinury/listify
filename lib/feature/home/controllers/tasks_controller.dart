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

  _TasksController({this.ref});

  void completeTask(uid) {
    ref.read(taskRepositoryProvider).completeTask(uid);
  }

  void undoCompleteTask(uid) {
    ref.read(taskRepositoryProvider).undoCompleteTask(uid);
  }

  void removeTodo(uid) {
    ref.read(taskRepositoryProvider).removeTodo(uid);
  }
}
