import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/qq_opensdk_api.g.dart',
  kotlinOut:
      'android/src/main/kotlin/com/dianyun/qq_opensdk_flutter/GeneratedMediaPluginApi.kt',
  objcSourceOut: 'ios/Classes/GeneratedQqOpenSdkPluginApi.g.m',
  objcHeaderOut: 'ios/Classes/GeneratedQqOpenSdkPluginApi.g.h',
))
enum QQSceneType { qq, qzone }

class QQShareBaseModel {
  String title;
  String content;
  String thumbImageUrl;
  QQSceneType scene;
  QQShareBaseModel(
      {required this.title, required this.content, required this.thumbImageUrl, required this.scene});
}

enum QQShareRetCode {
  success,
  failed,
  common,
  userCancel,
}

class QQSdkOnResp {
  int type;
  String? description;
  String? result;
  String? extendInfo;
  String? errorDescription;
  QQSdkOnResp({required this.type});
}

class QQShareWebPage {
  String pageUrl;
  QQShareBaseModel base;
  QQShareWebPage(
      {required this.pageUrl, required this.thumbImageUrl, required this.base});
}

class QQShareImage {
  final Uint8List? imageData;
  QQShareBaseModel base;

  QQShareImage({required this.imageData, required this.base});
}

@HostApi()
abstract class QQOpenSdkApi {
  @async
  void registerApp(String appId, String urlSchema, String? universalLink);

  @async
  bool isQQInstalled();

  @async
  bool joinQQGroup(String qqGroupInfo);

  @async
  bool shareWebPage(QQShareWebPage req);

  @async
  bool shareImage(QQShareImage req);
}

@FlutterApi()
abstract class QQSdkOnRespApi {
  void onResp(QQSdkOnResp resp);
}
