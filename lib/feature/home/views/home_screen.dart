import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/core/logger.dart';
import 'package:listify/data/model/todo.dart';
import 'package:listify/utils/navigation.dart';
import 'package:listify/core/base/base_view.dart';
import 'package:listify/feature/home/views/all_task_screen.dart';
import 'package:listify/feature/authentication/views/login_screen.dart';
import 'package:listify/utils/utils.dart';
import 'package:listify/widgets/k_expansion_tile.dart';
import 'package:listify/widgets/k_button.dart';
import 'package:listify/widgets/task_card.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../authentication/controllers/authentication_controller.dart';
import '../../create_task/views/create_task_screen.dart';
import '../controllers/tasks_controller.dart';

class HomeScreen extends BaseView {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseViewState<HomeScreen> {
  @override
  Widget appBar() {
    return _AppBarBuilder();
  }

  @override
  Widget body() {
    final pendingTasksStream = ref.watch(pendingTasksProvider);
    final completedTasksStream = ref.watch(completedTasksProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: ListifySize.height(35)),

        /// Create Task / Project
        KFilledButton.iconText(
          icon: Icons.add,
          buttonText: 'Create New Task',
          onPressed: () {
            CreateTaskScreen().push(context);
          },
        ),
        SizedBox(height: ListifySize.height(72)),

        /// Pending Tasks
        pendingTasksStream.when(
            loading: () => CircularProgressIndicator.adaptive(),
            error: (e, stackTrace) {
              Log.error(e.toString());
              Log.error(stackTrace.toString());
              return ErrorWidget(stackTrace);
            },
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
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                snackBar(context,
                    title: "Feature is not available yet",
                    backgroundColor: ListifyColors.charcoal);
              },
              child: Image.asset(
                ListifyAssets.menu,
                height: ListifySize.height(32),
                width: ListifySize.width(32),
              ),
            ),
            Text("My Day", style: ListifyTextStyle.headLine4),
            Consumer(builder: (context, ref, _) {
              return GestureDetector(
                onTap: () {
                  ref.read(authenticationProvider.notifier).signOut();
                  LoginScreen().pushAndRemoveUntil(context);
                },
                child: Image.asset(
                  ListifyAssets.logout,
                  height: ListifySize.height(32),
                  width: ListifySize.width(32),
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
                style: ListifyTextStyle.bodyText2().copyWith(
                  color: ListifyColors.charcoal.withOpacity(.71),
                ),
              ),
              Visibility(
                visible: snapshot.length > 4,
                child: GestureDetector(
                  onTap: () {
                    AllTasksScreen().push(context);
                  },
                  child: Text(
                    "View All",
                    style: ListifyTextStyle.bodyText2().copyWith(
                      color: ListifyColors.charcoal.withOpacity(.71),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ListifySize.height(20)),
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
      child: KExpansionTile(
        title: Text(
          "Done",
          style: ListifyTextStyle.bodyText2().copyWith(
            color: ListifyColors.charcoal.withOpacity(.71),
          ),
        ),
        trailing: Image.asset(
          ListifyAssets.dropdown,
          height: ListifySize.height(20),
          width: ListifySize.width(20),
        ),
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: snapshot.length,
              itemBuilder: (context, index) {
                return ProviderScope(
                  overrides: [taskProvider.overrideWithValue(snapshot[index])],
                  child: TaskCard(
                    borderOutline: false,
                    backgroundColor: ListifyColors.lightCharcoal,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
