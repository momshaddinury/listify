import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/tasks/tasks_provider.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/custom_widget/dropdown_menu.dart';
import 'package:listify/views/widgets/k_textfield.dart';
import 'package:listify/services/debouncer.dart';

class TaskDetailsCard extends ConsumerStatefulWidget {
  @override
  ConsumerState<TaskDetailsCard> createState() => _TaskCardState();
}

class _TaskCardState extends ConsumerState<TaskDetailsCard> {
  final _debouncer = Debouncer(milliseconds: 500);

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDetailsController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Todo _todo = ref.read(taskDetailsProvider);
    taskTitleController.text = _todo.title;
    taskDetailsController.text = _todo.description;
    dateTimeController.text = _todo.dateTime;
    priorityController.text = _todo.priority;
  }

  @override
  Widget build(BuildContext context) {
    final todoState = ref.watch(taskDetailsProvider.state);
    return Container(
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
                    color: todoState.state.priority == "Low"
                        ? Colors.green
                        : todoState.state.priority == "Medium"
                            ? Colors.orange
                            : Colors.red,
                    size: KSize.getWidth(16),
                  ),
                ),
                Flexible(
                  child: KTextField(
                    controller: taskTitleController,
                    textStyle: KTextStyle.bodyText2().copyWith(fontWeight: FontWeight.w600),
                    onChanged: (v) {
                      todoState.update((state) => state.copyWith(title: v));
                      _debouncer.run(() => ref.read(tasksProvider).updateTask(todoState.state.uid, title: v));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: KSize.getHeight(5)),
            KTextField(
              controller: taskDetailsController,
              textStyle: KTextStyle.bodyText3(),
              hintText: "Details",
              onChanged: (v) => _debouncer.run(() {
                todoState.update((state) => state.copyWith(description: v));
                _debouncer.run(() => ref.read(tasksProvider).updateTask(todoState.state.uid, description: v));
              }),
            ),
            SizedBox(height: KSize.getHeight(10)),
            KTextField(
              controller: dateTimeController,
              textStyle: KTextStyle.bodyText2().copyWith(
                color: KColors.charcoal.withOpacity(0.70),
              ),
              isDateTime: true,
              onChanged: (v) {
                todoState.update((state) => state.copyWith(dateTime: v));
                _debouncer.run(() => ref.read(tasksProvider).updateTask(todoState.state.uid, dateTime: v));
              },
            ),
            SizedBox(height: KSize.getHeight(10)),
            Row(
              children: [
                Text(
                  "Priority:",
                  style: KTextStyle.bodyText2(),
                ),
                Flexible(
                  child: DropdownMenus(
                    controller: priorityController,
                    items: ['Low', 'Medium', 'High'],
                    showTrailing: false,
                    menuBackgroundColor: KColors.transparent,
                    itemBackgroundColor: KColors.accent,
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    hintTextStyle: KTextStyle.bodyText2(),
                    onChange: () {
                      todoState.update((state) => state.copyWith(priority: priorityController.text));
                      _debouncer.run(() => ref.read(tasksProvider).updateTask(todoState.state.uid, priority: priorityController.text));
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
