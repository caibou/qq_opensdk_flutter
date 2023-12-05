//
//  QQOpenSdkApiImpl.h
//  qq_opensdk_flutter
//
//  Created by PC on 2023/11/1.
//


#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
#import "GeneratedQqOpenSdkPluginApi.g.h"

NS_ASSUME_NONNULL_BEGIN

@interface QQOpenSdkApiImpl : NSObject<QQOpenSdkApi,FlutterApplicationLifeCycleDelegate>

- (instancetype) initWithQQSdkOnRespApi:(QQSdkOnRespApi *)onRespApi;

@end

NS_ASSUME_NONNULL_END
