//
//  QQOpenSdkConstant.m
//  qq_opensdk_flutter
//
//  Created by kyros He on 2023/12/6.
//

#import "QQOpenSdkConstant.h"

@implementation QQOpenSdkConstant

+ (NSString *)NSStringFromTencentRetCode:(TencentRetCode)code {
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

@end
