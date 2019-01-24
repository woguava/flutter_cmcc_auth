#import "FlutterCmccAuthPlugin.h"
#import "MobileAuth.h"

#import <UIKit/UIKit.h>

@implementation FlutterCmccAuthPlugin {
  FlutterResult _result;
  UIViewController *_viewController;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_cmcc_auth"
            binaryMessenger:[registrar messenger]];
  UIViewController *viewController =
      [UIApplication sharedApplication].delegate.window.rootViewController;
  FlutterCmccAuthPlugin* instance = [[FlutterCmccAuthPlugin alloc] initWithViewController:viewController];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)initWithViewController:(UIViewController *)viewController {
  self = [super init];
  if (self) {
    _viewController = viewController;
  }
  return self;
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"mobileRegister" isEqualToString:call.method]) {
    NSString * appId = call.arguments[@"appId"]; 
    NSString * appKey = call.arguments[@"appkey"];
    long expiresIn = (nil != call.arguments[@"expiresln"]) ? [call.arguments[@"expiresln"] longValue]: 8000;
    [MobileAuth initSDK:appId appKey:appKey reqTimeout:expiresIn ];
    result(@"sucess");
  }else if ([@"mobileAuthThemeConfig" isEqualToString:call.method]) {
    NSDictionary *paramDict = call.arguments;
    [MobileAuth initWindowSytle:paramDict];
    result(@"sucess");
  }else if ([@"networdAndOperator" isEqualToString:call.method]) {
    [MobileAuth getNetAndOprate:result];
  }else if ([@"preGetphoneInfo" isEqualToString:call.method]) {
    [MobileAuth preGetphoneInfo:result];
  }else if ([@"displayLogin" isEqualToString:call.method]) {
    [MobileAuth displayLogin:_viewController result:result];
  }else if ([@"implicitLogin" isEqualToString:call.method]) {
    [MobileAuth implicitLogin:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
