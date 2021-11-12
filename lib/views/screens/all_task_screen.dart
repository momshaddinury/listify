import 'dart:io';

import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/controller/tasks/provider.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/create_task_button.dart';
import 'package:listify/views/widgets/task_card.dart';

class AllTasksScreen extends ConsumerWidget {
  const AllTasksScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingTasksStream = ref.watch(pendingTasksProvider);

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
                ExpandTapWidget(
                  onTap: () => Navigator.pop(context),
                  tapPadding: EdgeInsets.all(20.0),
                  child: Image.asset(
                    KAssets.backButton,
                    height: KSize.getHeight(context, 32),
                    width: KSize.getWidth(context, 32),
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
                  child: pendingTasksStream.when(
                      loading: () => Container(),
                      error: (e, stackTrace) => ErrorWidget(stackTrace),
                      data: (snapshot) {
                        return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.length,
                            itemBuilder: (context, index) {
                              return TaskCard(
                                snapshot[index],
                                backgroundColor: KColors.accent,
                                borderOutline: false,
                              );
                            });
                      }),
                ),
                SizedBox(height: KSize.getHeight(context, 20)),

                /// Create Task / Project
                Padding(
                  padding: EdgeInsets.only(bottom: Platform.isAndroid ? KSize.getHeight(context, 50) : 0),
                  child: CreateTaskButton(),
                ),
              ],
            ),
          ),
        ));
  }
}
