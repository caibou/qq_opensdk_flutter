import 'dart:async';

import 'package:flutter/services.dart';
import 'package:qq_opensdk_flutter/qq_opensdk_flutter.dart';
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

  Future<void> registerApp(
          {required String appId,
          required String urlSchema,
          String? universalLink}) =>
      api.registerApp(appId, urlSchema, universalLink);

  Future<bool> isQQInstalled() => api.isQQInstalled();

  Future<bool> joinQQGroup({required String info}) => api.joinQQGroup(info);

  Future<bool> shareWebPage({required QQShareWebPage req}) =>
      api.shareWebPage(req);

  Future<bool> shareImage({required QQShareImage req}) => api.shareImage(req);

  Future<String> qqAuth() => api.qqAuth().onError((error, stackTrace) =>
      throw SignInWithQQException.fromPlatformException(
          (error as PlatformException)));
}
