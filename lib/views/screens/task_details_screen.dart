import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:listify/controller/tasks/tasks_provider.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/buttons/k_filled_button.dart';
import 'package:listify/views/widgets/textfields/k_dropdown_textfield.dart';
import 'package:listify/views/widgets/textfields/k_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

class TaskDetailsScreen extends ConsumerStatefulWidget {
  final Todo todo;

  TaskDetailsScreen(this.todo);

  @override
  _UpdateTaskScreenState createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends ConsumerState<TaskDetailsScreen> {
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDetailsController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController priorityController = TextEditingController(text: 'Low');

  @override
  void initState() {
    super.initState();
    taskTitleController.text = widget.todo.title;
    taskDetailsController.text = widget.todo.description;
    dateTimeController.text = widget.todo.dateTime;
    priorityController.text = widget.todo.priority;
  }

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
                Container(),
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
                KTextField(
                  hintText: "Task Name",
                  controller: taskTitleController,
                ),
                SizedBox(height: KSize.getHeight(context, 22)),
                KTextField(
                  hintText: "Details",
                  controller: taskDetailsController,
                  multiline: true,
                ),
                SizedBox(height: KSize.getHeight(context, 22)),
                KTextField(
                  hintText: "Date Time",
                  controller: dateTimeController,
                  isCalanderField: true,
                ),
                SizedBox(height: KSize.getHeight(context, 22)),
                KDropdownField(
                  hintText: "Priority",
                  controller: priorityController,
                  dropdownFieldOptions: ['Low', 'Medium', 'High'],
                ),
                SizedBox(height: KSize.getHeight(context, 90)),
                KFilledButton(
                    buttonText: "Update Task",
                    onPressed: () async {
                      if (taskTitleController.text.trim().isNotEmpty) {
                        await ref.read(tasksProvider).updateTask(
                              widget.todo.uid,
                              taskTitleController.text,
                              taskDetailsController.text,
                              dateTimeController.text,
                              priorityController.text,
                            );
                        Navigator.pop(context);
                      } else {
                        snackBar(context, title: 'Please enter a task name', backgroundColor: KColors.charcoal);
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
