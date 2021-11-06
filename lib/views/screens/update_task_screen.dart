import 'package:flutter/material.dart';
import 'package:listify/controller/tasks/tasks_controller.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/buttons/k_filled_button.dart';
import 'package:listify/views/widgets/textfields/k_dropdown_textfield.dart';
import 'package:listify/views/widgets/textfields/k_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateTaskScreen extends StatefulWidget {
  final Todo todo;
  UpdateTaskScreen(this.todo);
  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController priorityController = TextEditingController(text: 'Low');

  @override
  void initState() {
    super.initState();
    taskTitleController.text = widget.todo.title;
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
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    KAssets.backButton,
                    height: KSize.getHeight(context, 32),
                    width: KSize.getWidth(context, 32),
                  ),
                ),
                Text("Update Task", style: KTextStyle.headLine4),
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
                    buttonText: "Add Task",
                    onPressed: () async {
                      await context.read(tasksProvider).updateTask(
                            widget.todo.uid,
                            taskTitleController.text,
                            dateTimeController.text,
                            priorityController.text,
                          );
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ));
  }
}
