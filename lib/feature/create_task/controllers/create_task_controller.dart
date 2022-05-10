import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/core/dependency/repository.dart';

import '../../../core/logger.dart';

final createTaskProvider = Provider((ref) => _CreateTaskController(ref: ref));

class _CreateTaskController {
  final Ref ref;

  _CreateTaskController({this.ref});

  Future<void> createNewTask(
      String title, description, dateTime, priority) async {
    try {
      ref
          .read(Repository.task)
          .createNewTask(title, description, dateTime, priority);
    } catch (error, stackTrace) {
      Log.error("createNewTask(): $error");
      Log.error(stackTrace.toString());
    }
  }
}
