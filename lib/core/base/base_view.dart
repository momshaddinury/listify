import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/services/network_status.dart';
import '../../views/screens/error_screen.dart';
import 'package:listify/views/screens/error_screen.dart';

class _BaseView {
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

  Widget body() => Container();

  void buildMethod() => () {};
}

class BaseView extends ConsumerStatefulWidget {
  BaseView({Key key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => BaseViewState();
}

class BaseViewState<Screen extends BaseView> extends ConsumerState<Screen>
    with _BaseView {}
