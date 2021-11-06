import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/authentication/authentication_controller.dart';
import 'package:listify/controller/tasks/tasks_controller.dart';
import 'package:listify/views/screens/all_task_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/create_task_button.dart';
import 'package:listify/views/widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              Image.asset(
                KAssets.menu,
                height: KSize.getHeight(context, 32),
                width: KSize.getWidth(context, 32),
              ),
              Text("My Day", style: KTextStyle.headLine4),
              GestureDetector(
                onTap: () {
                  context.read(firebaseAuthProvider).signOut();
                },
                child: Image.asset(
                  KAssets.logout,
                  height: KSize.getHeight(context, 32),
                  width: KSize.getWidth(context, 32),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 59)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: KSize.getHeight(context, 35)),

              /// Create Task / Project
              CreateTaskButton(),
              SizedBox(height: KSize.getHeight(context, 72)),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tasks",
                    style: KTextStyle.bodyText2().copyWith(
                      color: KColors.charcoal.withOpacity(.71),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AllTasksScreen()));
                    },
                    child: Text(
                      "View All",
                      style: KTextStyle.bodyText2().copyWith(
                        color: KColors.charcoal.withOpacity(.71),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: KSize.getHeight(context, 10)),

              /// Tasks
              StreamBuilder(
                  stream: context.read(tasksProvider).fetchTasks(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return TaskCard(snapshot.data[index]);
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}