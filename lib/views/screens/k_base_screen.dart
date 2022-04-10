import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/services/network_status.dart';
import 'error_screen.dart';
import 'package:listify/views/screens/error_screen.dart';

abstract class _BaseView {
  Widget build(BuildContext context) {
    buildMethod();
    return Scaffold(
      appBar: appBar(),
      body: Consumer(builder: (context, ref, _) {
        return ref.watch(networkStatusProvider).when(
            data: (network) {
              return network == NetworkStatus.OFFLINE
                  ? KErrorWidget()
                  : scrollable()
                      ? SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding() ? 25 : 0),
                              child: body()),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: defaultPadding() ? 25 : 0),
                          child: body());
            },
            loading: () => CircularProgressIndicator.adaptive(),
            error: (e, stackTrace) => KErrorWidget());
      }),
    );
  }

  bool scrollable() => true;

  bool defaultPadding() => true;

  Widget appBar() => null;

  Widget body();

  void buildMethod() => () {};
}

abstract class KBaseScreen extends ConsumerStatefulWidget {
  KBaseScreen({Key key}) : super(key: key);
}

abstract class KBaseState<Screen extends KBaseScreen>
    extends ConsumerState<Screen> with _BaseView {}
