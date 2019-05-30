#import <Flutter/Flutter.h>
#import <TYRZSDK/UACustomModel.h>

@interface MobileAuth : NSObject
+ (void) initSDK: (NSString*)appId appKey:(NSString*)appKey reqTimeout:(long)reqTimeout;
+ (UACustomModel *) initWindowSytle:(NSDictionary*)modeParam;
+ (void) getNetAndOprate:(FlutterResult)result;
+ (void) preGetphoneInfo:(FlutterResult)result;
+ (void) displayLogin:(UIViewController *)vc modeParam:(NSDictionary*)modeParam result:(FlutterResult)result;
+ (void) implicitLogin:(FlutterResult)result;
@end
