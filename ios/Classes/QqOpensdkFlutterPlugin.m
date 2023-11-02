#import "QQOpenSdkApiImpl.h"
#import "QqOpensdkFlutterPlugin.h"
#import "GeneratedQqOpenSdkPluginApi.g.h"

@implementation QqOpensdkFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    QQSdkOnRespApi* onRespApi = [[QQSdkOnRespApi alloc] initWithBinaryMessenger:registrar.messenger];
    QQOpenSdkApiImpl *impl = [[QQOpenSdkApiImpl alloc] init];
    [registrar addApplicationDelegate:(NSObject<FlutterPlugin> *)impl];
    QQOpenSdkApiSetup(registrar.messenger,impl);
}

- (void)detachFromEngineForRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    NSLog(@"QqOpensdkFlutterPlugin detachFromEngineForRegistrar");
}

@end
