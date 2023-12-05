import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qq_opensdk_flutter/qq_opensdk_flutter_method_channel.dart';

void main() {
  MethodChannelQqOpensdkFlutter platform = MethodChannelQqOpensdkFlutter();
  const MethodChannel channel = MethodChannel('qq_opensdk_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
