import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/tasks/tasks_provider.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/custom_widget/dropdown_menu.dart';
import 'package:listify/views/widgets/k_textfield.dart';
import 'package:listify/services/debouncer.dart';

class TaskCard extends ConsumerStatefulWidget {
  final Todo todo;

  TaskCard({this.todo});

  @override
  ConsumerState<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends ConsumerState<TaskCard> {
  final _debouncer = Debouncer(milliseconds: 500);

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDetailsController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    taskTitleController.text = widget.todo.title;
    taskDetailsController.text = widget.todo.description;
    dateTimeController.text = widget.todo.dateTime;
    priorityController.text = widget.todo.priority;
  }

  void _updateTaskHandler() async {
    if (taskTitleController.text != widget.todo.title ||
        taskDetailsController.text != widget.todo.description ||
        dateTimeController.text != widget.todo.dateTime ||
        priorityController.text != widget.todo.priority) {
      await ref.read(tasksProvider).updateTask(
            widget.todo.uid,
            taskTitleController.text,
            taskDetailsController.text,
            dateTimeController.text,
            priorityController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: KSize.getWidth(602),
      margin: EdgeInsets.only(bottom: KSize.getHeight(19)),
      padding: EdgeInsets.symmetric(vertical: KSize.getHeight(15)),
      decoration: BoxDecoration(
        color: KColors.accent,
        borderRadius: BorderRadius.circular(4),
      ),
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
                    color: widget.todo.priority == "Low"
                        ? Colors.green
                        : widget.todo.priority == "Medium"
                            ? Colors.orange
                            : Colors.red,
                    size: KSize.getWidth(16),
                  ),
                ),
                Flexible(
                  child: KTextField(
                    controller: taskTitleController,
                    textStyle: KTextStyle.bodyText2(),
                    onChanged: (v) => _debouncer.run(() => _updateTaskHandler()),
                  ),
                ),
              ],
            ),
            SizedBox(height: KSize.getHeight(5)),
            KTextField(
              controller: taskDetailsController,
              textStyle: KTextStyle.bodyText3(),
              hintText: "Details",
              onChanged: (v) => _debouncer.run(() => _updateTaskHandler()),
            ),
            SizedBox(height: KSize.getHeight(10)),
            KTextField(
              controller: dateTimeController,
              textStyle: KTextStyle.bodyText2().copyWith(
                color: KColors.charcoal.withOpacity(0.40),
              ),
              isDateTime: true,
              onChanged: (v) {
                _updateTaskHandler();
              },
            ),
            SizedBox(height: KSize.getHeight(10)),
            Row(
              children: [
                Text("Priority:"),
                Flexible(
                  child: DropdownMenus(
                    controller: priorityController,
                    items: ['Low', 'Medium', 'High'],
                    showTrailing: false,
                    menuBackgroundColor: KColors.transparent,
                    itemBackgroundColor: KColors.accent,
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    onChange: () {
                      _updateTaskHandler();
                      setState(() {});
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
