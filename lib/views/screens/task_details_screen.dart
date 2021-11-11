import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:listify/controller/tasks/tasks_controller.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/views/screens/update_task_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskDetailsScreen extends ConsumerStatefulWidget {
  final Todo todo;

  TaskDetailsScreen(this.todo);

  @override
  _UpdateTaskScreenState createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends ConsumerState<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          titleSpacing: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 59)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ExpandTapWidget(
                  onTap: () => Navigator.pop(context),
                  tapPadding: EdgeInsets.all(20.0),
                  child: Image.asset(
                    KAssets.backButton,
                    height: KSize.getHeight(context, 32),
                    width: KSize.getWidth(context, 32),
                  ),
                ),
                Text("Task Details", style: KTextStyle.headLine4),
                ExpandTapWidget(
                  tapPadding: EdgeInsets.all(25),
                  onTap: () {
                    ref.read(tasksProvider.notifier).removeTodo(widget.todo.uid);

                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.delete,
                    color: KColors.charcoal,
                    size: KSize.getWidth(context, 40),
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 59)),
            child: Column(
              children: [
                SizedBox(height: KSize.getHeight(context, 40)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateTaskScreen(widget.todo)));
                  },
                  child: Container(
                    width: KSize.getWidth(context, 602),
                    margin: EdgeInsets.only(bottom: KSize.getHeight(context, 19)),
                    child: Container(
                      width: KSize.getWidth(context, 602),
                      padding: EdgeInsets.symmetric(vertical: KSize.getHeight(context, 15)),
                      decoration: BoxDecoration(
                        color: KColors.accent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: KSize.getWidth(context, 22),
                                    right: KSize.getWidth(context, 41),
                                  ),
                                  child: Icon(
                                    Icons.brightness_1_sharp,
                                    color: widget.todo.priority == "Low"
                                        ? Colors.green
                                        : widget.todo.priority == "Medium"
                                            ? Colors.orange
                                            : Colors.red,
                                    size: KSize.getWidth(context, 16),
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.todo.title,
                                        style: KTextStyle.bodyText2(),
                                      ),
                                      if (widget.todo.description.length > 0)
                                        Column(
                                          children: [
                                            SizedBox(height: KSize.getHeight(context, 5)),
                                            Text(
                                              widget.todo.description,
                                              style: KTextStyle.bodyText3(),
                                            ),
                                            SizedBox(height: KSize.getHeight(context, 10)),
                                          ],
                                        ),
                                      Text(widget.todo.dateTime,
                                          style: KTextStyle.bodyText2().copyWith(
                                            color: KColors.charcoal.withOpacity(0.40),
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (!widget.todo.isCompleted)
                                await ref.read(tasksProvider.notifier).completeTask(widget.todo.uid);
                              else
                                await ref.read(tasksProvider.notifier).undoCompleteTask(widget.todo.uid);
                            },
                            child: Container(
                              margin: EdgeInsets.all(KSize.getWidth(context, 36)),
                              child: Icon(
                                widget.todo.isCompleted ? Icons.brightness_1 : Icons.brightness_1_outlined,
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
                SizedBox(height: KSize.getHeight(context, 90)),
              ],
            ),
          ),
        ));
  }
}
