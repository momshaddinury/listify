import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/services/authentication_service.dart';
import 'package:listify/views/screens/create_task_screen.dart';
import 'package:listify/views/styles/styles.dart';

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
                  KAssets.notification,
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateTaskScreen()),
                  );
                },
                child: Container(
                    height: KSize.getHeight(context, 82),
                    width: KSize.getWidth(context, 602),
                    decoration: BoxDecoration(
                      color: KColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: KSize.getWidth(context, 31)),
                        Icon(Icons.add, color: KColors.white),
                        SizedBox(width: KSize.getWidth(context, 24)),
                        Text(
                          "Create New Task / Project",
                          style: KTextStyle.bodyText2().copyWith(color: KColors.white),
                        )
                      ],
                    )),
              ),
              SizedBox(height: KSize.getHeight(context, 72)),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today",
                    style: KTextStyle.bodyText2().copyWith(
                      color: KColors.charcoal.withOpacity(.71),
                    ),
                  ),
                  Text(
                    "View All",
                    style: KTextStyle.bodyText2().copyWith(
                      color: KColors.charcoal.withOpacity(.71),
                    ),
                  ),
                ],
              ),
              SizedBox(height: KSize.getHeight(context, 10)),

              /// Tasks
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return TaskCard();
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: KSize.getHeight(context, 84),
      width: KSize.getWidth(context, 602),
      margin: EdgeInsets.only(bottom: KSize.getHeight(context, 19)),
      padding: EdgeInsets.symmetric(vertical: KSize.getHeight(context, 15)),
      decoration: BoxDecoration(
        border: Border.all(color: KColors.charcoal),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: KSize.getWidth(context, 22),
                    right: KSize.getWidth(context, 41),
                  ),
                  child: Icon(
                    Icons.brightness_1_sharp,
                    size: KSize.getWidth(context, 16),
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Integrate Firebase, Google Sign In, Task Sync",
                        style: KTextStyle.bodyText2(),
                      ),
                      Text("7.56 PM",
                          style: KTextStyle.bodyText2().copyWith(
                            color: KColors.charcoal.withOpacity(0.40),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: KSize.getWidth(context, 36)),
            child: Icon(
              Icons.brightness_1_outlined,
              color: KColors.primary,
              size: KSize.getWidth(context, 24),
            ),
          ),
        ],
      ),
    );
  }
}
