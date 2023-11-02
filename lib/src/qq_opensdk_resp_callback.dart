import 'dart:async';

import 'qq_opensdk_api.g.dart';

class QQOpenSdkRespCallBack extends QQSdkOnRespApi {
  final StreamController<QQSdkOnResp> qqSdkOnRespController =
      StreamController.broadcast();
  Stream<QQSdkOnResp> get onRespStream => qqSdkOnRespController.stream;

  @override
  void onResp(QQSdkOnResp resp) {
    qqSdkOnRespController.add(resp);
  }
}
