import 'package:flutter_test/flutter_test.dart';
import 'package:qq_opensdk_flutter/qq_opensdk_flutter.dart';
import 'package:qq_opensdk_flutter/qq_opensdk_flutter_platform_interface.dart';
import 'package:qq_opensdk_flutter/qq_opensdk_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockQqOpensdkFlutterPlatform
    with MockPlatformInterfaceMixin
    implements QqOpensdkFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final QqOpensdkFlutterPlatform initialPlatform = QqOpensdkFlutterPlatform.instance;

  test('$MethodChannelQqOpensdkFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelQqOpensdkFlutter>());
  });

  test('getPlatformVersion', () async {
    QqOpensdkFlutter qqOpensdkFlutterPlugin = QqOpensdkFlutter();
    MockQqOpensdkFlutterPlatform fakePlatform = MockQqOpensdkFlutterPlatform();
    QqOpensdkFlutterPlatform.instance = fakePlatform;

    expect(await qqOpensdkFlutterPlugin.getPlatformVersion(), '42');
  });
}
