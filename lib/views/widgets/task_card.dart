import 'package:flutter/material.dart';
import 'package:listify/controller/tasks/tasks_provider.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/details/details_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskCard extends ConsumerWidget {
  final Animation<double> animation;
  final Color backgroundColor;
  final bool borderOutline;

  TaskCard({this.animation, this.backgroundColor = KColors.white, this.borderOutline = true});

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
        margin: EdgeInsets.only(bottom: KSize.getHeight(19)),
        child: Dismissible(
          key: UniqueKey(),
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
            padding: EdgeInsets.symmetric(vertical: KSize.getHeight(15)),
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
                          padding: EdgeInsets.only(left: KSize.getWidth(22)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: KSize.getWidth(22)),
                                    child: Icon(
                                      Icons.brightness_1_sharp,
                                      color: task.priority == "Low"
                                          ? Colors.green
                                          : task.priority == "Medium"
                                              ? Colors.orange
                                              : Colors.red,
                                      size: KSize.getWidth(16),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      task.title,
                                      style: KTextStyle.bodyText2().copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              if (task.description.length > 0)
                                Column(
                                  children: [
                                    SizedBox(height: KSize.getHeight(5)),
                                    Text(
                                      task.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: KTextStyle.bodyText3(),
                                    ),
                                    SizedBox(height: KSize.getHeight(10)),
                                  ],
                                ),
                              Text(task.dateTime,
                                  style: KTextStyle.bodyText2().copyWith(
                                    color: KColors.charcoal.withOpacity(0.70),
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
                    margin: EdgeInsets.all(KSize.getWidth(36)),
                    child: Icon(
                      task.isCompleted ? Icons.brightness_1 : Icons.brightness_1_outlined,
                      color: KColors.primary,
                      size: KSize.getWidth(24),
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
