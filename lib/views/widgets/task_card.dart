import 'package:flutter/material.dart';
import 'package:listify/controller/tasks/provider.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/views/screens/task_details_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskCard extends ConsumerWidget {
  final Todo task;
  final Color backgroundColor;
  final bool borderOutline;

  TaskCard(this.task, {this.backgroundColor = KColors.white, this.borderOutline = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (!task.isCompleted) Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDetailsScreen(task)));
      },
      child: Container(
        width: KSize.getWidth(context, 602),
        margin: EdgeInsets.only(bottom: KSize.getHeight(context, 19)),
        child: Dismissible(
          key: Key(task.title),
          background: Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Icon(Icons.delete),
            color: KColors.lightRed,
          ),
          onDismissed: (direction) async {
            ref.read(tasksProvider).removeTodo(task.uid);
          },
          child: Container(
            width: KSize.getWidth(context, 602),
            // margin: EdgeInsets.only(bottom: KSize.getHeight(context, 19)),
            padding: EdgeInsets.symmetric(vertical: KSize.getHeight(context, 15)),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: borderOutline ? Border.all(color: KColors.charcoal) : null,
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
                          padding: EdgeInsets.only(
                            left: KSize.getWidth(context, 22),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: KSize.getWidth(context, 22),
                                    ),
                                    child: Icon(
                                      Icons.brightness_1_sharp,
                                      color: task.priority == "Low"
                                          ? Colors.green
                                          : task.priority == "Medium"
                                              ? Colors.orange
                                              : Colors.red,
                                      size: KSize.getWidth(context, 16),
                                    ),
                                  ),
                                  Text(
                                    task.title,
                                    style: KTextStyle.bodyText2(),
                                  ),
                                ],
                              ),
                              if (task.description.length > 0)
                                Column(
                                  children: [
                                    SizedBox(height: KSize.getHeight(context, 5)),
                                    Text(
                                      task.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: KTextStyle.bodyText3(),
                                    ),
                                    SizedBox(height: KSize.getHeight(context, 10)),
                                  ],
                                ),
                              Text(task.dateTime,
                                  style: KTextStyle.bodyText2().copyWith(
                                    color: KColors.charcoal.withOpacity(0.40),
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
                      await ref.read(tasksProvider).completeTask(task.uid);
                    else
                      await ref.read(tasksProvider).undoCompleteTask(task.uid);
                  },
                  child: Container(
                    margin: EdgeInsets.all(KSize.getWidth(context, 36)),
                    child: Icon(
                      task.isCompleted ? Icons.brightness_1 : Icons.brightness_1_outlined,
                      color: KColors.primary,
                      size: KSize.getWidth(context, 24),
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
