import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:listify/controller/tasks/tasks_provider.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/custom_widget/dropdown_menu.dart';
import 'package:listify/views/widgets/k_button.dart';
import 'package:listify/views/widgets/k_dropdown_field.dart';
import 'package:listify/views/widgets/k_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDetailsController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController priorityController = TextEditingController(text: 'Low');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          titleSpacing: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(59)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ExpandTapWidget(
                  onTap: () => Navigation.pop(context),
                  tapPadding: EdgeInsets.all(20.0),
                  child: Image.asset(
                    KAssets.backButton,
                    height: KSize.getHeight(32),
                    width: KSize.getWidth(32),
                  ),
                ),
                Text("New Task", style: KTextStyle.headLine4),
                Container(),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(59)),
            child: Column(
              children: [
                SizedBox(height: KSize.getHeight(40)),
                KTextField(
                  hintText: "Task Name",
                  controller: taskTitleController,
                ),
                SizedBox(height: KSize.getHeight(22)),
                KTextField(
                  hintText: "Details",
                  controller: taskDetailsController,
                  multiline: true,
                ),
                SizedBox(height: KSize.getHeight(22)),
                KTextField(
                  hintText: "Date Time",
                  controller: dateTimeController,
                  isCalanderField: true,
                ),
                SizedBox(height: KSize.getHeight(22)),
                KDropdownField(
                  controller: priorityController,
                  dropdownFieldOptions: ['Low', 'Medium', 'High'],
                ),
                SizedBox(height: KSize.getHeight(90)),
                KFilledButton(
                    buttonText: "Add Task",
                    onPressed: () async {
                      if (taskTitleController.text.trim().isNotEmpty) {
                        await ref.read(tasksProvider).createNewTask(
                              taskTitleController.text,
                              taskDetailsController.text,
                              dateTimeController.text,
                              priorityController.text,
                            );
                        Navigation.pop(context);
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
