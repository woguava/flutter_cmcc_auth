#import <Flutter/Flutter.h>

@interface MobileAuth : NSObject
+ (void) initSDK: (NSString*)appId appKey:(NSString*)appKey reqTimeout:(long)reqTimeout;
+ (void) initWindowSytle:(NSDictionary*)modeParam;
+ (void) getNetAndOprate:(FlutterResult)result;
+ (void) preGetphoneInfo:(FlutterResult)result;
+ (void) displayLogin:(UIViewController *)vc result:(FlutterResult)result;
+ (void) implicitLogin:(FlutterResult)result;
@end
