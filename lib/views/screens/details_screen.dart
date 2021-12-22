import 'package:flutter/material.dart';
import 'package:listify/controller/tasks/tasks_provider.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/services/debouncer.dart';
import 'package:listify/services/navigation_service.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/custom_widget/dropdown_menu.dart';
import 'package:listify/views/widgets/k_app_bar.dart';
import 'package:listify/views/widgets/k_button.dart';
import 'package:listify/views/widgets/k_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void _updateTaskHandler() async {
    if (taskTitleController.text != widget.todo.title ||
        taskDetailsController.text != widget.todo.description ||
        dateTimeController.text != widget.todo.dateTime ||
        priorityController.text != widget.todo.priority) {
      print('Check');
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
    return WillPopScope(
      onWillPop: () async {
        // _updateTaskHandler();
        return true;
      },
      child: Scaffold(
        appBar: KAppBar(
          titleText: "Task Details",
          onTap: () {
            // _updateTaskHandler();
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
                _TaskCard(todo: widget.todo),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: widget.todo.subtask.length,
                    itemBuilder: (context, index) {
                      return _SubTask(todo: widget.todo, index: index);
                    }),
                // SizedBox(height: KSize.getHeight(15)),
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
      ),
    );
  }
}

class _TaskCard extends ConsumerStatefulWidget {
  final Todo todo;

  _TaskCard({this.todo});

  @override
  ConsumerState<_TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends ConsumerState<_TaskCard> {
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
      print('Check');
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

class _SubTask extends ConsumerStatefulWidget {
  const _SubTask({
    Key key,
    @required this.todo,
    @required this.index,
  }) : super(key: key);

  final Todo todo;
  final int index;

  @override
  ConsumerState<_SubTask> createState() => _SubTaskState();
}

class _SubTaskState extends ConsumerState<_SubTask> {
  final _debouncer = Debouncer(milliseconds: 500);
  final TextEditingController subTaskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    subTaskController.text = widget.todo.subtask[widget.index].title;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: KSize.getHeight(15)),
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete),
          color: KColors.lightRed,
        ),
        onDismissed: (direction) {
          widget.todo.subtask.removeAt(widget.index);
          ref.read(tasksProvider).updateSubTask(widget.todo.uid, widget.todo.subtask);
        },
        child: Container(
          width: KSize.getWidth(602),
          padding: EdgeInsets.symmetric(vertical: KSize.getHeight(22), horizontal: KSize.getWidth(22)),
          decoration: BoxDecoration(
            color: KColors.accent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: KTextField(
                  controller: subTaskController,
                  hintText: 'Enter title',
                  onChanged: (String value) {
                    widget.todo.subtask[widget.index].title = value;
                    _debouncer.run(() {
                      ref.read(tasksProvider).updateSubTask(widget.todo.uid, widget.todo.subtask);
                    });
                  },
                  textStyle: KTextStyle.bodyText2(),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (widget.todo.subtask[widget.index].isCompleted == false) {
                    widget.todo.subtask[widget.index].isCompleted = true;
                  } else {
                    widget.todo.subtask[widget.index].isCompleted = false;
                  }
                  ref.read(tasksProvider).updateSubTask(widget.todo.uid, widget.todo.subtask);

                  setState(() {});
                },
                child: Icon(
                  widget.todo.subtask[widget.index].isCompleted ? Icons.brightness_1 : Icons.brightness_1_outlined,
                  color: KColors.primary,
                  size: KSize.getWidth(24),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
