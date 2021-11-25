import 'dart:io';

import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listify/controller/tasks/tasks_controller.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/create_task_button.dart';
import 'package:listify/views/widgets/task_card.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskController = Get.put(TasksController());

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
                  onTap: () => Get.back(),
                  tapPadding: EdgeInsets.all(20.0),
                  child: Image.asset(
                    KAssets.backButton,
                    height: KSize.getHeight(32),
                    width: KSize.getWidth(32),
                  ),
                ),
                Text("All Tasks", style: KTextStyle.headLine4),
                Container()
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(59)),
            child: Column(
              children: [
                SizedBox(height: KSize.getHeight(20)),
                Expanded(
                  child: StreamBuilder<List<Todo>>(
                      stream: taskController.pendingTasks(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.active) {
                          return Visibility(
                            visible: snapshot.data.length > 0,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Pending",
                                      style: KTextStyle.bodyText2().copyWith(
                                        color: KColors.charcoal.withOpacity(.71),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: KSize.getHeight(10)),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return TaskCard(
                                        snapshot.data[index],
                                        borderOutline: false,
                                        backgroundColor: KColors.accent,
                                      );
                                    }),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
                SizedBox(height: KSize.getHeight(20)),

                /// Create Task / Project
                Padding(
                  padding: EdgeInsets.only(bottom: Platform.isAndroid ? KSize.getHeight(50) : 0),
                  child: CreateTaskButton(),
                ),
              ],
            ),
          ),
        ));
  }
}
