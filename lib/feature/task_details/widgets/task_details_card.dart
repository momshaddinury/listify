import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/data/model/todo.dart';
import 'package:listify/utils/utils.dart';
import 'package:listify/widgets/dropdown_menu.dart';
import 'package:listify/widgets/k_textfield.dart';
import 'package:listify/utils/debouncer.dart';

import '../controllers/task_details_controller.dart';

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
      margin: EdgeInsets.only(bottom: ListifySize.height(19)),
      padding: EdgeInsets.symmetric(vertical: ListifySize.height(15)),
      decoration: BoxDecoration(
        color: ListifyColors.accent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: ListifySize.width(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: ListifySize.width(22)),
                  child: Icon(
                    Icons.brightness_1_sharp,
                    color: todoState.state.priority == "Low"
                        ? Colors.green
                        : todoState.state.priority == "Medium"
                            ? Colors.orange
                            : Colors.red,
                    size: ListifySize.width(16),
                  ),
                ),
                Flexible(
                  child: KTextField(
                    controller: taskTitleController,
                    textStyle: ListifyTextStyle.bodyText2()
                        .copyWith(fontWeight: FontWeight.w600),
                    onChanged: (v) {
                      todoState.update((state) => state.copyWith(title: v));
                      _debouncer.run(() => ref
                          .read(taskDetailsViewControllerProvider)
                          .updateTask(todoState.state.uid, title: v));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: ListifySize.height(5)),
            KTextField(
              controller: taskDetailsController,
              textStyle: ListifyTextStyle.bodyText3(),
              hintText: "Details",
              onChanged: (v) => _debouncer.run(() {
                todoState.update((state) => state.copyWith(description: v));
                _debouncer.run(() => ref
                    .read(taskDetailsViewControllerProvider)
                    .updateTask(todoState.state.uid, description: v));
              }),
            ),
            SizedBox(height: ListifySize.height(10)),
            KTextField(
              controller: dateTimeController,
              textStyle: ListifyTextStyle.bodyText2().copyWith(
                color: ListifyColors.charcoal.withOpacity(0.70),
              ),
              isDateTime: true,
              onChanged: (v) {
                todoState.update((state) => state.copyWith(dateTime: v));
                _debouncer.run(() => ref
                    .read(taskDetailsViewControllerProvider)
                    .updateTask(todoState.state.uid, dateTime: v));
              },
            ),
            SizedBox(height: ListifySize.height(10)),
            Row(
              children: [
                Text(
                  "Priority:",
                  style: ListifyTextStyle.bodyText2(),
                ),
                Flexible(
                  child: DropdownMenus(
                    controller: priorityController,
                    items: ['Low', 'Medium', 'High'],
                    showTrailing: false,
                    menuBackgroundColor: ListifyColors.transparent,
                    itemBackgroundColor: ListifyColors.accent,
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    hintTextStyle: ListifyTextStyle.bodyText2(),
                    onChange: () {
                      todoState.update((state) =>
                          state.copyWith(priority: priorityController.text));
                      _debouncer.run(() => ref
                          .read(taskDetailsViewControllerProvider)
                          .updateTask(todoState.state.uid,
                              priority: priorityController.text));
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
