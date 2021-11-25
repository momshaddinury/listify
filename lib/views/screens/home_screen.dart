import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listify/controller/authentication/authentication_controller.dart';
import 'package:listify/controller/tasks/tasks_controller.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/views/screens/all_task_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/create_task_button.dart';
import 'package:listify/views/widgets/snack_bar.dart';
import 'package:listify/views/widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthenticationController());
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
              GestureDetector(
                onTap: () => kSnackBar('Warning', "Feature is not available yet"),
                child: Image.asset(
                  KAssets.menu,
                  height: KSize.getHeight(32),
                  width: KSize.getWidth(32),
                ),
              ),
              Text("My Day", style: KTextStyle.headLine4),
              GestureDetector(
                onTap: () => authController.signOut(),
                child: Image.asset(
                  KAssets.logout,
                  height: KSize.getHeight(32),
                  width: KSize.getWidth(32),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(59)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: KSize.getHeight(35)),

              /// Create Task / Project
              CreateTaskButton(),
              SizedBox(height: KSize.getHeight(72)),

              /// Pending Tasks
              StreamBuilder<List<Todo>>(
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
                                Visibility(
                                  visible: snapshot.data.length > 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => AllTasksScreen());
                                    },
                                    child: Text(
                                      "View All",
                                      style: KTextStyle.bodyText2().copyWith(
                                        color: KColors.charcoal.withOpacity(.71),
                                      ),
                                    ),
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
                                  return TaskCard(snapshot.data[index]);
                                }),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),

              /// Completed Tasks
              StreamBuilder<List<Todo>>(
                  stream: taskController.completedTasks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      return Visibility(
                        visible: snapshot.data.length > 0,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Done",
                                  textAlign: TextAlign.left,
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
                                    backgroundColor: KColors.lightCharcoal,
                                  );
                                }),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
