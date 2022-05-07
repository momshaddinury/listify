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
  TaskRepository _repository;

  _TaskDetailsController({this.ref}) {
    _repository = ref.watch(taskRepositoryProvider);
  }

  Future<void> updateTask(uid,
      {String title,
      String description,
      String dateTime,
      String priority}) async {
    try {
      _repository.updateTask(
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

  void updateSubTask() => _repository.updateSubTask();

  void completeTask(uid) => _repository.completeTask(uid);

  void undoCompleteTask(uid) => _repository.undoCompleteTask(uid);

  void removeTodo(uid) => _repository.removeTodo(uid);
}
