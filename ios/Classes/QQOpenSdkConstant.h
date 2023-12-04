//
//  QQOpenSdkConstant.h
//  Pods
//
//  Created by kyros He on 2023/12/5.
//

#ifndef QQOpenSdkConstant_h
#define QQOpenSdkConstant_h

typedef NS_ENUM(NSInteger, TencentRetCode) {
    // 网络请求成功发送至服务器，并且服务器返回数据格式正确
    // 这里包括所请求业务操作失败的情况，例如没有授权等原因导致
    RET_SUCCESS    = 0,
    // 网络异常，或服务器返回的数据格式不正确导致无法解析
    RET_FAILED     = 1,
    RET_COMMON     = -1,
    RET_USERCANCEL = -2,
};

NSString * NSStringFromTencentRetCode(TencentRetCode code) {
    switch (code) {
        case RET_SUCCESS:
            return @"RET_SUCCESS";

        case RET_FAILED:
            return @"RET_FAILED";

        case RET_COMMON:
            return @"RET_COMMON";

        case RET_USERCANCEL:
            return @"RET_USERCANCEL";

        default:
            return @"Unknown Code";
    }
}

#endif /* QQOpenSdkConstant_h */
