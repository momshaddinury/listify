import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/data/model/todo.dart';
import 'package:listify/utils/utils.dart';
import 'package:listify/widgets/k_textfield.dart';
import 'package:listify/utils/debouncer.dart';

import '../controllers/task_details_controller.dart';

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
    subTaskController.text =
        ref.read(taskDetailsProvider).subTask[widget.index].title;
  }

  @override
  Widget build(BuildContext context) {
    final subTaskState = ref.watch(taskDetailsProvider.state);
    return Padding(
      padding: EdgeInsets.only(bottom: ListifySize.height(15)),
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete),
          color: ListifyColors.lightRed,
        ),
        onDismissed: (direction) {
          subTaskState.update((state) {
            state.subTask.removeAt(widget.index);
            return state.copyWith(subTask: state.subTask);
          });
          ref.read(taskDetailsViewControllerProvider).updateSubTask();
        },
        child: Container(
          decoration: BoxDecoration(
            color: ListifyColors.accent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: ListifySize.width(22),
                    top: ListifySize.height(22),
                    bottom: ListifySize.height(22),
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
                        ref
                            .read(taskDetailsViewControllerProvider)
                            .updateSubTask();
                      });
                    },
                    textStyle: ListifyTextStyle.bodyText2()
                        .copyWith(fontWeight: FontWeight.normal),
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
                  subTaskState.update(
                      (state) => state.copyWith(subTask: state.subTask));
                  ref.read(taskDetailsViewControllerProvider).updateSubTask();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ListifySize.height(22),
                      horizontal: ListifySize.width(22)),
                  child: Icon(
                    subTaskState.state.subTask[widget.index].isCompleted
                        ? Icons.brightness_1
                        : Icons.brightness_1_outlined,
                    color: ListifyColors.primary,
                    size: ListifySize.width(24),
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
