import 'package:flutter/material.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/buttons/k_filled_button.dart';
import 'package:listify/views/widgets/textfields/k_textfield.dart';

class CreateTaskScreen extends StatelessWidget {
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
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    KAssets.backButton,
                    height: KSize.getHeight(context, 62.23),
                    width: KSize.getWidth(context, 62.23),
                  ),
                ),
                Text("New Task", style: KTextStyle.headLine4),
                Image.asset(
                  KAssets.notification,
                  height: KSize.getHeight(context, 32),
                  width: KSize.getWidth(context, 32),
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
              children: [
                SizedBox(height: KSize.getHeight(context, 40)),
                KTextField(
                  hintText: "Task Name",
                ),
                SizedBox(height: KSize.getHeight(context, 22)),
                KTextField(
                  hintText: "Time",
                ),
                SizedBox(height: KSize.getHeight(context, 90)),
                KFilledButton(
                    buttonText: "Add Task",
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ));
  }
}
