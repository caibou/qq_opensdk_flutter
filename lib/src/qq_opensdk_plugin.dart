import 'dart:async';

import 'package:qq_opensdk_flutter/src/qq_opensdk_resp_callback.dart';

import 'qq_opensdk_api.g.dart';

class QQOpenSdkPlugin {
  final QQOpenSdkApi api = QQOpenSdkApi();
  final QQOpenSdkRespCallBack _sdkResp = QQOpenSdkRespCallBack();
  Stream<QQSdkOnResp> get onRespStream => _sdkResp.onRespStream;

  factory QQOpenSdkPlugin() => _instance;
  static final QQOpenSdkPlugin _instance = QQOpenSdkPlugin._();

  QQOpenSdkPlugin._() {
    QQSdkOnRespApi.setup(_sdkResp);
  }
}
