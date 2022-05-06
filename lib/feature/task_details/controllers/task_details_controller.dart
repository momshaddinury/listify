import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/data/repository/task/task_repository.dart';

import '../../../core/logger.dart';
import '../../../data/model/todo.dart';

final taskDetailsProvider = StateProvider<Todo>((ref) {
  return Todo();
});

final taskDetailsViewControllerProvider =
    Provider((ref) => _TaskDetailsController(ref: ref));

class _TaskDetailsController {
  final Ref ref;

  _TaskDetailsController({this.ref});

  Future<void> updateTask(uid,
      {String title,
      String description,
      String dateTime,
      String priority}) async {
    try {
      ref.read(taskRepositoryProvider).updateTask(
            uid,
            title: title,
            description: description,
            dateTime: dateTime,
            priority: priority,
          );
    } catch (error, stackTrace) {
      Log.error(error);
      Log.error(stackTrace.toString());
    }
  }

  void updateSubTask() => ref.read(taskRepositoryProvider).updateSubTask();

  void completeTask(uid) => ref.read(taskRepositoryProvider).completeTask(uid);

  void undoCompleteTask(uid) =>
      ref.read(taskRepositoryProvider).undoCompleteTask(uid);

  void removeTodo(uid) => ref.read(taskRepositoryProvider).removeTodo(uid);
}
