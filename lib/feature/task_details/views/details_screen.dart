import 'package:flutter/material.dart';
import 'package:listify/feature/home/controllers/tasks_provider.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/utils/navigation.dart';
import 'package:listify/feature/task_details/widgets/sub_task_card.dart';
import 'package:listify/core/base/base_view.dart';
import 'package:listify/utils/utils.dart';
import 'package:listify/widgets/k_app_bar.dart';
import 'package:listify/widgets/k_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/task_details_card.dart';

class DetailsScreen extends BaseView {
  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends BaseViewState<DetailsScreen> {
  @override
  Widget appBar() {
    return KAppBar(
      titleText: "Task Details",
      onTap: () => Navigation.pop(context),
    );
  }

  @override
  Widget body() {
    final todoState = ref.watch(taskDetailsProvider.state);

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: ListifySize.height(40)),
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
            assetIcon: ListifyAssets.add,
            onPressed: () {
              todoState.update((state) {
                state.subTask.add(SubTask());
                return state.copyWith(subTask: state.subTask);
              });
              ref.read(tasksProvider).updateSubTask();
            }),
        SizedBox(height: ListifySize.height(90)),
        KFilledButton(
          buttonText: "Complete Task",
          onPressed: () async {
            await ref.read(tasksProvider).completeTask(todoState.state.uid);
            Navigation.pop(context);
          },
        ),
        SizedBox(height: ListifySize.height(22)),
        KOutlinedButton(
          buttonText: "Delete Task",
          textStyle: ListifyTextStyle.buttonText(fontWeight: FontWeight.w500)
              .copyWith(color: ListifyColors.red.withOpacity(0.8)),
          borderColor: ListifyColors.red.withOpacity(0.8),
          onPressed: () async {
            await ref.read(tasksProvider).removeTodo(todoState.state.uid);
            Navigation.pop(context);
          },
        ),
        SizedBox(height: ListifySize.height(90)),
      ],
    );
  }
}
