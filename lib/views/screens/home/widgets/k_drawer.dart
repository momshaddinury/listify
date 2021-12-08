import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listify/view_model/authentication_view_model.dart';
import 'package:listify/views/styles/k_assets.dart';
import 'package:listify/views/styles/styles.dart';
import 'package:listify/views/widgets/snack_bar.dart';

class KDrawer extends StatefulWidget {
  const KDrawer({Key key}) : super(key: key);

  @override
  _KDrawerState createState() => _KDrawerState();
}

class _KDrawerState extends State<KDrawer> {
  AuthenticationViewModel authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "",
              style: KTextStyle.headLine4,
            ),
            accountEmail: Text(
              authController.getCurrentUser().email,
              style: KTextStyle.headLine4,
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  KAssets.appLogo,
                  height: 76,
                  width: 76,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Image.asset(
              KAssets.notification,
              height: KSize.getHeight(32),
              width: KSize.getWidth(32),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Notification',
                style: KTextStyle.bodyText1(),
              ),
            ),
            onTap: () => kSnackBar('Warning', 'Feature not available yet'),
          ),
          ListTile(
            leading: Image.asset(
              KAssets.logout,
              height: KSize.getHeight(32),
              width: KSize.getWidth(32),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Logout',
                style: KTextStyle.bodyText1(),
              ),
            ),
            onTap: () => authController.signOut(),
          ),
        ],
      ),
    );
  }
}
