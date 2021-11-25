import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:listify/views/screens/create_task_screen.dart';
import 'package:listify/views/styles/styles.dart';

class CreateTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CreateTaskScreen());
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
                "Create New Task",
                style: KTextStyle.bodyText2().copyWith(color: KColors.white),
              )
            ],
          )),
    );
  }
}
