//
//  QQOpenSdkConstant.h
//  qq_opensdk_flutter
//
//  Created by kyros He on 2023/12/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TencentRetCode) {
    // 网络请求成功发送至服务器，并且服务器返回数据格式正确
    // 这里包括所请求业务操作失败的情况，例如没有授权等原因导致
    RET_SUCCESS    = 0,
    // 网络异常，或服务器返回的数据格式不正确导致无法解析
    RET_FAILED     = 1,
    RET_COMMON     = -1,
    RET_USERCANCEL = -2,
};

@interface QQOpenSdkConstant : NSObject

+ (NSString *)NSStringFromTencentRetCode:(TencentRetCode)code;

@end

NS_ASSUME_NONNULL_END
