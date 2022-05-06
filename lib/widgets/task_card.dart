import 'package:flutter/material.dart';
import 'package:listify/utils/navigation.dart';
import 'package:listify/feature/task_details/views/details_screen.dart';
import 'package:listify/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../feature/home/controllers/tasks_controller.dart';
import '../feature/task_details/controllers/task_details_controller.dart';

class TaskCard extends ConsumerWidget {
  final Animation<double> animation;
  final Color backgroundColor;
  final bool borderOutline;

  TaskCard(
      {this.animation,
      this.backgroundColor = ListifyColors.white,
      this.borderOutline = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider);

    return GestureDetector(
      onTap: () {
        if (!task.isCompleted) {
          ref.watch(taskDetailsProvider.state).state = task;
          DetailsScreen().push(context);
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: ListifySize.height(19)),
        child: Dismissible(
          key: UniqueKey(),
          background: Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Icon(Icons.delete),
            color: ListifyColors.lightRed,
          ),
          onDismissed: (direction) async {
            ref.read(tasksProvider).removeTodo(task.uid);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: ListifySize.height(15)),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: borderOutline
                  ? Border.all(color: ListifyColors.charcoal)
                  : null,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(left: ListifySize.width(22)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: ListifySize.width(22)),
                                    child: Icon(
                                      Icons.brightness_1_sharp,
                                      color: task.priority == "Low"
                                          ? Colors.green
                                          : task.priority == "Medium"
                                              ? Colors.orange
                                              : Colors.red,
                                      size: ListifySize.width(16),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      task.title,
                                      style: ListifyTextStyle.bodyText2()
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              if (task.description.length > 0)
                                Column(
                                  children: [
                                    SizedBox(height: ListifySize.height(5)),
                                    Text(
                                      task.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: ListifyTextStyle.bodyText3(),
                                    ),
                                    SizedBox(height: ListifySize.height(10)),
                                  ],
                                ),
                              Text(task.dateTime,
                                  style: ListifyTextStyle.bodyText2().copyWith(
                                    color: ListifyColors.charcoal
                                        .withOpacity(0.70),
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (!task.isCompleted)
                      ref.read(tasksProvider).completeTask(task.uid);
                    else
                      ref.read(tasksProvider).undoCompleteTask(task.uid);
                  },
                  child: Container(
                    margin: EdgeInsets.all(ListifySize.width(36)),
                    child: Icon(
                      task.isCompleted
                          ? Icons.brightness_1
                          : Icons.brightness_1_outlined,
                      color: ListifyColors.primary,
                      size: ListifySize.width(24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
