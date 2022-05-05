import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { ONLINE, OFFLINE }

final _initNetworkStatusProvider = FutureProvider<NetworkStatus>((ref) async {
  NetworkStatus _networkStatus;
  _networkStatus = await Connectivity().checkConnectivity().then((result) =>
      result == ConnectivityResult.wifi || result == ConnectivityResult.mobile
          ? NetworkStatus.ONLINE
          : NetworkStatus.OFFLINE);
  return _networkStatus;
});

final networkStatusProvider = StreamProvider<NetworkStatus>((ref) {
  // ignore: close_sinks
  StreamController<NetworkStatus> controller =
      StreamController<NetworkStatus>();

  // ref.onDispose(() {
  //   controller.close();
  // });

  controller.sink.add(ref.watch(_initNetworkStatusProvider).value);

  Connectivity().onConnectivityChanged.listen((result) {
    controller.add(
        result == ConnectivityResult.wifi || result == ConnectivityResult.mobile
            ? NetworkStatus.ONLINE
            : NetworkStatus.OFFLINE);
  });
  return controller.stream;
});
