import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/services/network_status.dart';

import 'error_screen.dart';
import 'startup/welcome_screen.dart';

abstract class _BaseView {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Consumer(builder: (context, ref, _) {
        final asyncNetworkStatus = ref.watch(networkStatusProvider);

        return asyncNetworkStatus.when(
          data: (result) {
            return scrollable()
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding() ? 25 : 0),
                      child: result == NetworkStatus.ONLINE
                          ? body()
                          : ErrorScreen(),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding() ? 25 : 0),
                    child:
                        result == NetworkStatus.ONLINE ? body() : ErrorScreen(),
                  );
          },
          loading: () => WelcomeScreen(),
          error: (e, stackTrace) => ErrorScreen(),
        );
      }),
    );
  }

  bool scrollable() => true;

  bool defaultPadding() => true;

  Widget appBar() => null;

  Widget body();
}

abstract class KBaseScreen extends ConsumerStatefulWidget {
  KBaseScreen({Key key}) : super(key: key);
}

abstract class KBaseState<Screen extends KBaseScreen>
    extends ConsumerState<Screen> with _BaseView {}
