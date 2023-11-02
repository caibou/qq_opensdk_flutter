// Autogenerated from Pigeon (v11.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, QQSceneType) {
  QQSceneTypeQq = 0,
  QQSceneTypeQzone = 1,
};

/// Wrapper for QQSceneType to allow for nullability.
@interface QQSceneTypeBox : NSObject
@property(nonatomic, assign) QQSceneType value;
- (instancetype)initWithValue:(QQSceneType)value;
@end

typedef NS_ENUM(NSUInteger, QQShareRetCode) {
  QQShareRetCodeSuccess = 0,
  QQShareRetCodeFailed = 1,
  QQShareRetCodeCommon = 2,
  QQShareRetCodeUserCancel = 3,
};

/// Wrapper for QQShareRetCode to allow for nullability.
@interface QQShareRetCodeBox : NSObject
@property(nonatomic, assign) QQShareRetCode value;
- (instancetype)initWithValue:(QQShareRetCode)value;
@end

@class QQShareBaseModel;
@class QQSdkOnResp;
@class QQShareWebPage;
@class QQShareImage;

@interface QQShareBaseModel : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithTitle:(NSString *)title
    content:(NSString *)content
    thumbImageUrl:(NSString *)thumbImageUrl
    scene:(QQSceneType)scene;
@property(nonatomic, copy) NSString * title;
@property(nonatomic, copy) NSString * content;
@property(nonatomic, copy) NSString * thumbImageUrl;
@property(nonatomic, assign) QQSceneType scene;
@end

@interface QQSdkOnResp : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithType:(NSNumber *)type
    description:(nullable NSString *)description
    result:(nullable NSString *)result
    extendInfo:(nullable NSString *)extendInfo
    errorDescription:(nullable NSString *)errorDescription;
@property(nonatomic, strong) NSNumber * type;
@property(nonatomic, copy, nullable) NSString * description;
@property(nonatomic, copy, nullable) NSString * result;
@property(nonatomic, copy, nullable) NSString * extendInfo;
@property(nonatomic, copy, nullable) NSString * errorDescription;
@end

@interface QQShareWebPage : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithPageUrl:(NSString *)pageUrl
    base:(QQShareBaseModel *)base;
@property(nonatomic, copy) NSString * pageUrl;
@property(nonatomic, strong) QQShareBaseModel * base;
@end

@interface QQShareImage : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithImageData:(nullable FlutterStandardTypedData *)imageData
    base:(QQShareBaseModel *)base;
@property(nonatomic, strong, nullable) FlutterStandardTypedData * imageData;
@property(nonatomic, strong) QQShareBaseModel * base;
@end

/// The codec used by QQOpenSdkApi.
NSObject<FlutterMessageCodec> *QQOpenSdkApiGetCodec(void);

@protocol QQOpenSdkApi
- (void)registerAppAppId:(NSString *)appId urlSchema:(NSString *)urlSchema universalLink:(nullable NSString *)universalLink completion:(void (^)(FlutterError *_Nullable))completion;
- (void)isQQInstalledWithCompletion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)joinQQGroupQqGroupInfo:(NSString *)qqGroupInfo completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)shareWebPageReq:(QQShareWebPage *)req completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)shareImageReq:(QQShareImage *)req completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
@end

extern void QQOpenSdkApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<QQOpenSdkApi> *_Nullable api);

/// The codec used by QQSdkOnRespApi.
NSObject<FlutterMessageCodec> *QQSdkOnRespApiGetCodec(void);

@interface QQSdkOnRespApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)onRespResp:(QQSdkOnResp *)resp completion:(void (^)(FlutterError *_Nullable))completion;
@end

NS_ASSUME_NONNULL_END
