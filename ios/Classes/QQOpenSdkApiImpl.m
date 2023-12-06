//
//  QQOpenSdkApiImpl.m
//  qq_opensdk_flutter
//
//  Created by PC on 2023/11/1.
//

#import "QQOpenSdkApiImpl.h"
#import "QQOpenSdkConstant.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>

#define KQQLoginCompletionCallBack @"kQQLoginCompletionCallBack"

static NSString * const kJOINGROUPDEEPLINK = @"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external";
typedef void (^completion_t)(NSString *_Nullable, FlutterError *_Nullable);

@interface QQOpenSdkApiImpl()<TencentSessionDelegate,QQApiInterfaceDelegate>

@property (nonatomic, strong) QQSdkOnRespApi *onRespApi;
@property (nonatomic, strong) NSString *appID;
@property (nonatomic, strong) NSString *urlSchema;
@property (nonatomic, strong) NSString *universalLink;
@property (nonatomic, strong) TencentOAuth* tencentOAuth;
@property (nonatomic, strong) NSMutableDictionary<NSString *, completion_t> *replyDict;

@end

@implementation QQOpenSdkApiImpl

- (NSMutableDictionary<NSString *, completion_t> *)replyDict {
    if (!_replyDict) {
        [self setReplyDict:[NSMutableDictionary dictionary]];
    }

    return _replyDict;
}

- (instancetype)initWithQQSdkOnRespApi:(QQSdkOnRespApi *)onRespApi {
    self = [super init];
    if (self) {
        self.onRespApi = onRespApi;
    }
    return self;
}

- (void)isQQInstalledWithCompletion:(nonnull void (^)(NSNumber * _Nullable, FlutterError * _Nullable))completion { 
    if (completion) {
        completion([NSNumber numberWithBool:[TencentOAuth iphoneQQInstalled]],nil);
    }
}

- (void)joinQQGroupQqGroupInfo:(nonnull NSString *)qqGroupInfo 
                    completion:(nonnull void (^)(NSNumber * _Nullable, FlutterError * _Nullable))completion {
    NSString *urlStr = [NSString stringWithFormat:kJOINGROUPDEEPLINK, qqGroupInfo, nil];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    if (![[UIApplication sharedApplication] canOpenURL:url]) {
        if (completion) {
            completion([NSNumber numberWithBool:NO],nil);
        }
        return;
    } else {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                if (completion) {
                    completion([NSNumber numberWithBool:success],nil);
                }
            }];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
            BOOL success =  [[UIApplication sharedApplication] openURL:url];
            if (completion) {
                completion([NSNumber numberWithBool:success],nil);
            }
#pragma clang diagnostic pop
        }
    }
}

- (void)registerAppAppId:(nonnull NSString *)appId 
               urlSchema:(nonnull NSString *)urlSchema
           universalLink:(nullable NSString *)universalLink
              completion:(nonnull void (^)(FlutterError * _Nullable))completion {
    self.appID  = appId;
    self.urlSchema = urlSchema;
    self.universalLink = universalLink;
    
    if (appId && universalLink) {
        self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:appId andUniversalLink:universalLink andDelegate:self];
    } else if (appId) {
        self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:appId andDelegate:self];
    }

    if (completion) {
        completion(nil);
    }
}

- (void)shareWebPageReq:(QQShareWebPage *)req 
             completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion {
    
    if(!req) {
        if (completion) {
            completion([NSNumber numberWithBool:NO],nil);
        }
        return;
    }
    
    QQApiNewsObject *obj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:req.pageUrl]
                                       title:req.base.title
                                 description:req.base.content
                             previewImageURL:[NSURL URLWithString:req.base.thumbImageUrl]];
    
    [self sendReq:[SendMessageToQQReq reqWithContent:obj] scene:req.base.scene completion:completion];
}

- (void)shareImageReq:(QQShareImage *)req 
           completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion {
    
    if(!req) {
        if (completion) {
            completion([NSNumber numberWithBool:NO],nil);
        }
        return;
    }
    
    QQApiImageObject *obj = [QQApiImageObject objectWithData:req.imageData.data
                                               previewImageData:nil
                                                          title:req.base.title
                                                    description:req.base.content];
    
    [self sendReq:[SendMessageToQQReq reqWithContent:obj] scene:req.base.scene completion:completion];
}

// qq 登录申请
- (void)qqAuthWithCompletion:(nonnull void (^)(NSString *_Nullable, FlutterError *_Nullable))completion {
    // 防止 retain cycle
    __weak typeof(self) _self = self;
    // 调起 qq 在 tencentDidLogin 中回调获取token返回
    [[self replyDict] setValue:completion forKey:KQQLoginCompletionCallBack];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(_self) self = _self;
        if(self) {
            [self authCallBack:nil error:[self authRet:RET_COMMON]];
        }
    });
    [self.tencentOAuth authorize:@[kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO]];
}

- (void)sendReq:(QQBaseReq *)req 
          scene:(QQSceneType)scene
     completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion {
    
    switch (scene) {
        case QQSceneTypeQq: {
            QQApiSendResultCode code = [QQApiInterface sendReq:req];
            if (completion){
                completion([NSNumber numberWithBool:code == EQQAPISENDSUCESS],nil);
            }
            break;
        }
        case QQSceneTypeQzone: {
            QQApiSendResultCode code = [QQApiInterface SendReqToQZone:req];
            if (completion){
                completion([NSNumber numberWithBool:code == EQQAPISENDSUCESS],nil);
            }
            break;
        }
        default:
            if (completion) {
                completion([NSNumber numberWithBool:NO],nil);
            }
            break;
    }
}


#pragma mark -TencentSessionDelegate
- (void)tencentDidLogin {
    NSString* qqToken = self.tencentOAuth.accessToken;
    if(qqToken != nil && qqToken.length > 0) {
        [self authCallBack:qqToken error:nil];
    } else {
        [self authCallBack:nil error:[self authRet:RET_COMMON]];
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled { 
    if(cancelled) {
        // 取消登录
        [self authCallBack:nil error:[self authRet:RET_USERCANCEL]];
    } else {
        // 登录失败
        [self authCallBack:nil error:[self authRet:RET_COMMON]];
    }
}

- (void)tencentDidNotNetWork { 
    [self authCallBack:nil error:[self authRet:RET_COMMON]];
}

- (void)authCallBack:(NSString *)response error:(FlutterError *_Nullable)error {
    completion_t reply = [[self replyDict] objectForKey:KQQLoginCompletionCallBack];

    if (reply) {
        reply(response, error);
        [[self replyDict] removeObjectForKey:KQQLoginCompletionCallBack];
    }
}

- (FlutterError *_Nullable) authRet:(TencentRetCode) code {
    FlutterError *_Nullable error = [FlutterError errorWithCode:[QQOpenSdkConstant NSStringFromTencentRetCode:code] message:nil details:nil];
    return error;
}

#pragma mark -QQApiInterfaceDelegate
- (void)isOnlineResponse:(NSDictionary *)response {
    
}

- (void)onReq:(QQBaseReq *)req { 
    
}

- (void)onResp:(QQBaseResp *)resp {
    if (!self.onRespApi) return;
    
    if ([resp isKindOfClass:[SendMessageToQQResp class]]) {
        SendMessageToQQResp *qqResp = ((SendMessageToQQResp *)resp);
        QQSdkOnResp *onResp = [QQSdkOnResp makeWithType:@(qqResp.type)
                                                 result:qqResp.result == nil ? @"" : qqResp.result
                                             extendInfo:qqResp.extendInfo == nil ? @"" : qqResp.extendInfo
                                       errorDescription:qqResp.errorDescription == nil ? @"" : qqResp.errorDescription];
        
        [self.onRespApi onRespResp:onResp completion:^(FlutterError * _Nullable err) {}];
    }
}

#pragma mark -FlutterApplicationLifeCycleDelegate
- (BOOL)application:(UIApplication*)application
            openURL:(NSURL*)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id>*)options {
    if (self.urlSchema && [[url scheme] isEqualToString: self.urlSchema]) {
        [QQApiInterface handleOpenURL:url delegate:self];
        return [TencentOAuth HandleOpenURL:url];
    }
    return NO;
}

- (BOOL)application:(UIApplication*)application
    continueUserActivity:(NSUserActivity*)userActivity
 restorationHandler:(void (^)(NSArray*))restorationHandler { 
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL *url = userActivity.webpageURL;
        NSString *strUrl = url.absoluteString;
        if (self.appID && [strUrl containsString:self.appID]) {
            NSURL *url = userActivity.webpageURL;
            if (url && [TencentOAuth CanHandleUniversalLink:url]) {
                [QQApiInterface handleOpenUniversallink:url delegate:self];
                return [TencentOAuth HandleUniversalLink:url];
            }
        }
    }
    return NO;
}

@end
