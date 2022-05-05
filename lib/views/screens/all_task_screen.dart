import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/tasks/tasks_provider.dart';
import 'package:listify/utils/navigation.dart';
import 'package:listify/core/base/base_view.dart';
import 'package:listify/utils/utils.dart';
import 'package:listify/views/widgets/k_app_bar.dart';
import 'package:listify/views/widgets/k_button.dart';
import 'package:listify/views/widgets/task_card.dart';

import 'create_task_screen.dart';

class AllTasksScreen extends BaseView {
  @override
  BaseViewState<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends BaseViewState<AllTasksScreen> {
  @override
  Widget appBar() {
    return KAppBar(
      titleText: "All Tasks",
      onTap: () => Navigation.pop(context),
    );
  }

  @override
  bool scrollable() {
    return false;
  }

  @override
  Widget body() {
    final pendingTasksStream = ref.watch(pendingTasksProvider);

    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: ListifySize.height(20)),
          Expanded(
            child: pendingTasksStream.when(
                loading: () => Container(),
                error: (e, stackTrace) => ErrorWidget(stackTrace),
                data: (snapshot) {
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.length,
                      itemBuilder: (context, index) {
                        return ProviderScope(
                          overrides: [
                            taskProvider.overrideWithValue(snapshot[index]),
                          ],
                          child: TaskCard(
                            backgroundColor: ListifyColors.accent,
                            borderOutline: false,
                          ),
                        );
                      });
                }),
          ),
          SizedBox(height: ListifySize.height(20)),

          /// Create Task / Project
          Padding(
            padding: EdgeInsets.only(
                bottom: Platform.isAndroid ? ListifySize.height(50) : 0),
            child: KFilledButton.iconText(
                icon: Icons.add,
                buttonText: 'Create New Task',
                onPressed: () {
                  CreateTaskScreen().push(context);
                }),
          ),
        ],
      ),
    );
  }
}
