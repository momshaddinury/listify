import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listify/view_model/tasks_view_model.dart';
import 'package:listify/data/model/todo.dart';
import 'package:listify/views/screens/tasks/all_task_screen.dart';
import 'package:listify/views/screens/home/widgets/k_drawer.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/create_task_button.dart';
import 'package:listify/views/widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final tasksVM = Get.put(TasksViewModel());
    return Scaffold(
      key: _scaffoldKey,
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
                onTap: () => _scaffoldKey.currentState.openDrawer(),
                child: Image.asset(
                  KAssets.menu,
                  height: KSize.getHeight(32),
                  width: KSize.getWidth(32),
                ),
              ),
              Text("My Day", style: KTextStyle.headLine4),
              Container(height: KSize.getHeight(32), width: KSize.getWidth(32)),
            ],
          ),
        ),
      ),
      drawer: KDrawer(),
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
                  stream: tasksVM.pendingTasks(),
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
                  stream: tasksVM.completedTasks(),
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
