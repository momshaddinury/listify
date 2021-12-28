import 'package:flutter/material.dart';
import 'package:listify/controller/tasks/tasks_provider.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/details/widget/sub_task_card.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/k_app_bar.dart';
import 'package:listify/views/widgets/k_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widget/task_details_card.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  const DetailsScreen({Key key}) : super(key: key);

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final todoState = ref.watch(taskDetailsProvider.state);
    return Scaffold(
      appBar: KAppBar(
        titleText: "Task Details",
        onTap: () => Navigation.pop(context),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: KSize.getHeight(40)),
              TaskDetailsCard(),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: todoState.state.subTask.length,
                  itemBuilder: (context, index) {
                    return SubTaskCard(key: UniqueKey(), index: index);
                  }),
              KTextButton.iconText(
                  buttonText: 'Add Task',
                  assetIcon: KAssets.add,
                  onPressed: () {
                    todoState.update((state) {
                      state.subTask.add(SubTask());
                      return state.copyWith(subTask: state.subTask);
                    });
                    ref.read(tasksProvider).updateSubTask();
                  }),
              SizedBox(height: KSize.getHeight(90)),
              KFilledButton(
                buttonText: "Complete Task",
                onPressed: () async {
                  await ref.read(tasksProvider).completeTask(todoState.state.uid);
                  Navigation.pop(context);
                },
              ),
              SizedBox(height: KSize.getHeight(22)),
              KOutlinedButton(
                buttonText: "Delete Task",
                textStyle: KTextStyle.buttonText(fontWeight: FontWeight.w500).copyWith(color: KColors.red.withOpacity(0.8)),
                borderColor: KColors.red.withOpacity(0.8),
                onPressed: () async {
                  await ref.read(tasksProvider).removeTodo(todoState.state.uid);
                  Navigation.pop(context);
                },
              ),
              SizedBox(height: KSize.getHeight(90)),
            ],
          ),
        ),
      ),
    );
  }
}
