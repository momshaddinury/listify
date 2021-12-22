import 'package:flutter/material.dart';
import 'package:listify/controller/tasks/tasks_provider.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/screens/details/widget/sub_task_card.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/k_app_bar.dart';
import 'package:listify/views/widgets/k_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widget/task_details_card.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  final Todo todo;

  const DetailsScreen({Key key, @required this.todo}) : super(key: key);

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        titleText: "Task Details",
        onTap: () {
          Navigation.pop(context);
        },
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(59)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: KSize.getHeight(40)),
              TaskCard(todo: widget.todo),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: widget.todo.subtask.length,
                  itemBuilder: (context, index) {
                    return SubTaskCard(todo: widget.todo, index: index);
                  }),
              InkWell(
                onTap: () {
                  widget.todo.subtask.add(SubTask());
                  ref.read(tasksProvider).updateSubTask(widget.todo.uid, widget.todo.subtask);
                  setState(() {});
                },
                child: Row(
                  children: [
                    Image.asset(
                      KAssets.add,
                      width: KSize.getWidth(20),
                      height: KSize.getHeight(20),
                    ),
                    SizedBox(width: KSize.getWidth(15)),
                    Text(
                      "Add task",
                      style: KTextStyle.bodyText3(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: KSize.getHeight(90)),
              KFilledButton(
                buttonText: "Complete Task",
                onPressed: () async {
                  await ref.read(tasksProvider).completeTask(widget.todo.uid);
                  Navigation.pop(context);
                },
              ),
              SizedBox(height: KSize.getHeight(22)),
              KOutlinedButton(
                buttonText: "Delete Task",
                textStyle: KTextStyle.buttonText(fontWeight: FontWeight.w500).copyWith(color: KColors.red.withOpacity(0.5)),
                borderColor: KColors.lightRed,
                onPressed: () async {
                  await ref.read(tasksProvider).removeTodo(widget.todo.uid);
                  Navigation.pop(context);
                },
              ),
              SizedBox(height: KSize.getHeight(90)),
            ],
          ),
        ),
      ),
    );
  }
}


