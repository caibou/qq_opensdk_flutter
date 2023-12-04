import 'package:flutter/services.dart';

abstract class SignInWithQQException implements Exception {
  factory SignInWithQQException.fromPlatformException(
    PlatformException exception,
  ) {
    switch (exception.code) {
      case 'RET_USERCANCEL':
        return SignInWithQQAuthorizationException(
            code: QQAuthorizationErrorCode.canceled,
            message: exception.message ?? 'no message provided');
      case 'RET_FAILED':
        return SignInWithQQAuthorizationException(
            code: QQAuthorizationErrorCode.failed,
            message: exception.message ?? 'no message provided');
      case 'RET_COMMON':
        return SignInWithQQAuthorizationException(
            code: QQAuthorizationErrorCode.common,
            message: exception.message ?? 'no message provided');
      default:
        return UnknownSignInWithQQException(platformException: exception);
    }
  }
}

class SignInWithQQAuthorizationException implements SignInWithQQException {
  const SignInWithQQAuthorizationException({
    required this.code,
    required this.message,
  });

  /// A more exact code of what actually went wrong
  final QQAuthorizationErrorCode code;

  /// A localized message of the error
  final String message;

  @override
  String toString() => 'SignInWithQQAuthorizationError($code, $message)';
}

class UnknownSignInWithQQException extends PlatformException
    implements SignInWithQQException {
  UnknownSignInWithQQException({
    required PlatformException platformException,
  }) : super(
          code: platformException.code,
          message: platformException.message,
          details: platformException.details,
        );

  @override
  String toString() =>
      'UnknownSignInWithQQException($code, $message, $details)';
}

/// TencentRetCode: https://github.com/RxReader/tencent_kit/blob/9631cc1db5de9bc3c291db4ae3d02b554e691fcf/ios/Classes/TencentKitPlugin.m#L10
enum QQAuthorizationErrorCode {
  /// The user canceled the authorization attempt.
  canceled,

  /// 网络异常，或服务器返回的数据格式不正确导致无法解析
  failed,

  /// 网络异常，或服务器返回的数据格式不正确导致无法解析
  common,

  /// The authorization attempt failed for an unknown reason.
  unknown,
}
