import 'package:flutter/material.dart';
import 'package:listify/controller/tasks/tasks_controller.dart';
import 'package:listify/views/global_widgets/create_task_button.dart';
import 'package:listify/views/global_widgets/task_card.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_task_screen.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({Key key}) : super(key: key);

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
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    KAssets.backButton,
                    height: KSize.getHeight(context, 62.23),
                    width: KSize.getWidth(context, 62.23),
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
            padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 59)),
            child: Column(
              children: [
                SizedBox(height: KSize.getHeight(context, 20)),
                Expanded(
                  child: StreamBuilder(
                      stream: context.read(tasksProvider).fetchTasks(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container();
                        }
                        return ListView.builder(
                            // shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return TaskCard(snapshot.data[index]);
                            });
                      }),
                ),

                /// Create Task / Project
                CreateTaskButton(),
              ],
            ),
          ),
        ));
  }
}
