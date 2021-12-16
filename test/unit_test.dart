import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listify/controller/tasks/tasks_provider.dart';
import 'package:listify/model/todo.dart';

void main() {
  test('Pending Task List', () async {
    final container = ProviderContainer(overrides: [
      pendingTasksProvider.overrideWithValue(
        AsyncValue.data([Todo(isCompleted: false)]),
      )
    ]);

    await container.read(pendingTasksProvider.future);

    expect(container.read(pendingTasksProvider).value, [isA<Todo>().having((s) => s.isCompleted, 'is task completed', false)]);
  });

  test('Done Task List', () async {
    final container = ProviderContainer(overrides: [
      completedTasksProvider.overrideWithValue(
        AsyncValue.data([Todo(isCompleted: true)]),
      )
    ]);

    await container.read(completedTasksProvider.future);

    expect(container.read(completedTasksProvider).value, [isA<Todo>().having((s) => s.isCompleted, 'is task completed', true)]);
  });
}
