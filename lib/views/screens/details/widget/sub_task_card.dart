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
    @required this.index,
  }) : super(key: key);

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
    subTaskController.text = ref.read(taskDetailsProvider).subTask[widget.index].title;
  }

  @override
  Widget build(BuildContext context) {
    final subTaskState = ref.watch(taskDetailsProvider.state);
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
          subTaskState.update((state) {
            state.subTask.removeAt(widget.index);
            return state.copyWith(subTask: state.subTask);
          });
          ref.read(tasksProvider).updateSubTask();
        },
        child: Container(
          decoration: BoxDecoration(
            color: KColors.accent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: KSize.getWidth(22),
                    top: KSize.getHeight(22),
                    bottom: KSize.getHeight(22),
                  ),
                  child: KTextField(
                    controller: subTaskController,
                    hintText: 'Enter title',
                    onChanged: (String value) {
                      _debouncer.run(() {
                        subTaskState.update((state) {
                          state.subTask[widget.index].title = value;
                          return state;
                        });
                        ref.read(tasksProvider).updateSubTask();
                      });
                    },
                    textStyle: KTextStyle.bodyText2().copyWith(fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  SubTask _subTask = subTaskState.state.subTask[widget.index];
                  if (_subTask.isCompleted == false) {
                    _subTask.isCompleted = true;
                  } else {
                    _subTask.isCompleted = false;
                  }
                  subTaskState.update((state) => state.copyWith(subTask: state.subTask));
                  ref.read(tasksProvider).updateSubTask();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: KSize.getHeight(22), horizontal: KSize.getWidth(22)),
                  child: Icon(
                    subTaskState.state.subTask[widget.index].isCompleted ? Icons.brightness_1 : Icons.brightness_1_outlined,
                    color: KColors.primary,
                    size: KSize.getWidth(24),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
