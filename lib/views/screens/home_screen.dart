import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/authentication/authentication_provider.dart';
import 'package:listify/controller/tasks/tasks_provider.dart';
import 'package:listify/model/todo.dart';
import 'package:listify/views/screens/all_task_screen.dart';
import 'package:listify/views/screens/auth/login_screen.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/buttons/create_task_button.dart';
import 'package:listify/views/widgets/task_card.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final pendingTasksStream = ref.watch(pendingTasksProvider);
    final completedTasksStream = ref.watch(completedTasksProvider);
    return Scaffold(
      appBar: _AppBarBuilder(),
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

              /// Pending Tasks
              pendingTasksStream.when(
                  loading: () => Container(),
                  error: (e, stackTrace) => ErrorWidget(stackTrace),
                  data: (snapshot) {
                    return _PendingTasksBuilder(snapshot: snapshot);
                  }),

              /// Completed Tasks
              completedTasksStream.when(
                  loading: () => Container(),
                  error: (e, stackTrace) => ErrorWidget(stackTrace),
                  data: (snapshot) {
                    return _CompletedTasksBuilder(snapshot: snapshot);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBarBuilder extends StatelessWidget with PreferredSizeWidget {
  _AppBarBuilder({
    Key key,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              onTap: () {
                snackBar(context, title: "Feature is not available yet", backgroundColor: KColors.charcoal);
              },
              child: Image.asset(
                KAssets.menu,
                height: KSize.getHeight(context, 32),
                width: KSize.getWidth(context, 32),
              ),
            ),
            Text("My Day", style: KTextStyle.headLine4),
            Consumer(builder: (context, ref, _) {
              return GestureDetector(
                onTap: () {
                  ref.read(firebaseAuthProvider.notifier).signOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                },
                child: Image.asset(
                  KAssets.logout,
                  height: KSize.getHeight(context, 32),
                  width: KSize.getWidth(context, 32),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _PendingTasksBuilder extends StatelessWidget {
  const _PendingTasksBuilder({
    Key key,
    @required this.snapshot,
  }) : super(key: key);

  final List<Todo> snapshot;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: snapshot.length > 0,
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
                visible: snapshot.length > 4,
                child: GestureDetector(
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
              ),
            ],
          ),
          SizedBox(height: KSize.getHeight(context, 10)),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.length,
              itemBuilder: (context, index) {
                return ProviderScope(
                  overrides: [taskProvider.overrideWithValue(snapshot[index])],
                  child: TaskCard(),
                );
              }),
        ],
      ),
    );
  }
}

class _CompletedTasksBuilder extends StatelessWidget {
  const _CompletedTasksBuilder({
    Key key,
    @required this.snapshot,
  }) : super(key: key);

  final List<Todo> snapshot;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: snapshot.length > 0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Done",
                style: KTextStyle.bodyText2().copyWith(
                  color: KColors.charcoal.withOpacity(.71),
                ),
              ),
            ],
          ),
          SizedBox(height: KSize.getHeight(context, 10)),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.length,
              itemBuilder: (context, index) {
                return ProviderScope(
                  overrides: [taskProvider.overrideWithValue(snapshot[index])],
                  child: TaskCard(
                    borderOutline: false,
                    backgroundColor: KColors.lightCharcoal,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
