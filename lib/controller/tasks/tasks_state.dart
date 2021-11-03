abstract class TasksState {
  const TasksState();
}

class TasksInitialState extends TasksState {
  const TasksInitialState();
}

class TasksLoadingState extends TasksState {
  const TasksLoadingState();
}

class TasksSuccessState extends TasksState {
  const TasksSuccessState();
}

class TasksErrorState extends TasksState {
  const TasksErrorState();
}
