import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/tasks/tasks_provider.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/k_textfield.dart';
import 'package:listify/services/debouncer.dart';

class SubTaskCard extends ConsumerStatefulWidget {
  const SubTaskCard({
    Key key,
    @required this.todo,
    @required this.index,
  }) : super(key: key);

  final Todo todo;
  final int index;

  @override
  ConsumerState<SubTaskCard> createState() => _SubTaskState();
}

class _SubTaskState extends ConsumerState<SubTaskCard> {
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
