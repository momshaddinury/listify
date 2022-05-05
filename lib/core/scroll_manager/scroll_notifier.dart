import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/navigation.dart';
import 'scroll_state.dart';

class ScrollNotifier extends StateNotifier<ScrollState> {
  final Ref ref;

  ScrollNotifier({this.ref}) : super(ScrollInitialState());

  final _scrollController = ScrollController();

  get controller {
    _scrollController.addListener(scrollListener);
    return _scrollController;
  }

  get scrollNotifierState => state;

  scrollListener() {
    double _maxScrollExtent = _scrollController.position.maxScrollExtent;
    double _currentScrollPosition = _scrollController.position.pixels;
    double _amountOfSpaceFromTheBottom =
        Navigation.key.currentContext.size.width * 0.20;

    if (state is! ScrollReachedBottomState) {
      if (_maxScrollExtent - _currentScrollPosition <=
          _amountOfSpaceFromTheBottom) {
        if (state is! ScrollPauseState) state = ScrollReachedBottomState();
      }
    }
  }

  void decideScrollState(bool shouldPaginate) {
    if (shouldPaginate)
      resetState();
    else
      pauseState();
  }

  void resetState() {
    state = ScrollInitialState();
  }

  void pauseState() {
    toast("You have reached the end of the list");
    state = ScrollPauseState();
  }
}
