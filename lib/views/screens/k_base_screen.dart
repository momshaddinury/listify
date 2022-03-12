import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class _BaseView {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: scrollable()
          ? SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: defaultPadding() ? 25 : 0),
                child: body(),
              ),
            )
          : Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: defaultPadding() ? 25 : 0),
              child: body(),
            ),
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
