#import <TYRZSDK/TYRZSDK.h>
#import "MobileAuth.h"


#define TITLE_BTN @"1"
#define BODY_BTN  @"2"

UIColor *hexColor(long hex) {
    long red = (hex & 0xff0000) >> 16;
    long green = (hex & 0x00ff00) >> 8;
    long blue = (hex & 0x0000ff) >> 0;
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
};

BOOL isExistKeyValue(NSDictionary* dict, NSString* key ) {
    if(![dict objectForKey:key]){
        return NO;
    }
    id obj = [dict objectForKey:key];
    return ![obj isEqual:[NSNull null]];
}

@implementation MobileAuth

FlutterResult _result;
UIViewController *_viewController;

+ (void) initSDK: (NSString*)appId appKey:(NSString*)appKey reqTimeout:(long)reqTimeout {
  //存好APPID和APPKEY
  [[NSUserDefaults standardUserDefaults]setObject:appId forKey:@"CMCC_APPID"];
  [[NSUserDefaults standardUserDefaults]setObject:appKey forKey:@"CMCC_APPKEY"];
  [[NSUserDefaults standardUserDefaults]setInteger:reqTimeout forKey:@"TCMCC_REQTIMEOUT"];

  // 初始化SDK
  //[TYRZUILogin initializeWithAppId:appId appKey:appKey];
  [UASDKLogin.shareLogin registerAppId:appId AppKey:appKey];
}

+ (UACustomModel *) initWindowSytle:(NSDictionary*)modeParam {
  //是否打印日志
  BOOL  cmccDebug = isExistKeyValue(modeParam,@"cmccDebug") ? [[modeParam objectForKey:@"cmccDebug"] boolValue]: NO;
  //[TYRZUILogin printConsoleEnable:cmccDebug];
  [UASDKLogin.shareLogin printConsoleEnable:cmccDebug];
  // 自定义短信验证码开关
 // BOOL useCmccSms = isExistKeyValue(modeParam,@"useCmccSms") ? [[modeParam objectForKey:@"useCmccSms"] boolValue]: NO;
  //[TYRZUILogin enableCustomSMS:useCmccSms];
  
  UACustomModel *model = [[UACustomModel alloc]init];
  model.currentVC = _viewController;

  //授权页导航栏
  /**
    navColor	UIColor	设置导航栏颜色
    navText	NSAttributedString	设置导航栏标题文字
    barStyle	UIBarStyle	状态栏着色样式
    navReturnImg	UIImage	设置导航栏返回按钮图标
    navControl	UIBarButtonItem	导航栏右侧自定义控件
  */
  long navHexColor = isExistKeyValue(modeParam,@"navColor")  ? [[modeParam objectForKey:@"navColor"] longValue]: -108766 ;
  model.navColor = hexColor(navHexColor);
    
  long navTextHexColor = isExistKeyValue(modeParam,@"navTextColor")  ? [[modeParam objectForKey:@"navTextColor"] longValue]: -1 ;
  model.navText = [[NSAttributedString alloc]initWithString:isExistKeyValue(modeParam,@"navText") ? [modeParam objectForKey:@"navText"] : @"统一认证登录" attributes:@{NSForegroundColorAttributeName:hexColor(navTextHexColor)}];
  //状态栏着色样式0为黑色,1为白色
  model.barStyle = 0;
  NSString * navRtnImgPath = isExistKeyValue(modeParam,@"navReturnImgPath") ? [modeParam objectForKey:@"navReturnImgPath"] : @"cmcc_return_bg";
  model.navReturnImg =  [UIImage imageNamed:navRtnImgPath];

  //授权界面背景图片
  NSString * authBGImgPath = isExistKeyValue(modeParam,@"authBGImgPath") ? [modeParam objectForKey:@"authBGImgPath"] : @"cmcc_root_bg";
  model.authPageBackgroundImage =  [UIImage imageNamed:authBGImgPath];

  //导航栏自定义（适配全屏图片
  model.navCustom = isExistKeyValue(modeParam,@"authNavTransparent") ? [[modeParam objectForKey:@"authNavTransparent"] boolValue]: NO;

  BOOL custTitBtnHid = isExistKeyValue(modeParam,@"customTitleBtnHidden") ? [[modeParam objectForKey:@"customTitleBtnHidden"] boolValue]: YES;
  if(!custTitBtnHid){
      model.navControl = [[UIBarButtonItem alloc]initWithTitle:[modeParam objectForKey:@"customTitleBtnText"] style:(UIBarButtonItemStyleDone) target:self action:@selector(customTitleAction)];
  }
  
  //授权页logo
  /**
    logoImg	UIImage	设置logo图片
    logoWidth	CGFloat	设置logo宽度
    logoHeight	CGFloat	设置logo高度
    logoOffsetY	CGFloat	设置logo相对于标题栏下边缘y偏移
    logoHidden	BOOL	隐藏logo
  */
  NSString * logoImgPath = isExistKeyValue(modeParam,@"logoImgPath") ? [modeParam objectForKey:@"logoImgPath"] : @"cmcc_login_logo";
  model.logoImg = [UIImage imageNamed:logoImgPath];
  model.logoWidth = isExistKeyValue(modeParam,@"logoWidth") ? [[modeParam objectForKey:@"logoWidth"] doubleValue] : 120;
  model.logoHeight = isExistKeyValue(modeParam,@"logoHeight") ? [[modeParam objectForKey:@"logoHeight"] doubleValue] : 80;
  model.logoOffsetY = isExistKeyValue(modeParam,@"logoOffsetY") ? [[modeParam objectForKey:@"logoOffsetY"] doubleValue] : 100;
  model.logoHidden = isExistKeyValue(modeParam,@"logoHidden") ? [[modeParam objectForKey:@"logoHidden"] boolValue] : NO;

  //号码栏
  /**
    oldStyle	BOOL	显示旧版号码栏样式，YES时显示旧版样式
    numberColor	UIColor	手机号码字体颜色
    numFieldOffsetY	CGFloat	号码栏Y相对于标题栏下边缘y偏移
  */
  //model.old = NO;
  long numberHexColor = isExistKeyValue(modeParam,@"numberColor") ? [[modeParam objectForKey:@"numberColor"] longValue]:  -108766 ;
  model.numberColor = hexColor(numberHexColor);
  model.numberSize = isExistKeyValue(modeParam,@"numberSize") ? [[modeParam objectForKey:@"numberSize"] doubleValue] : 12;
  model.numFieldOffsetY = isExistKeyValue(modeParam,@"numFieldOffsetY") ? [[modeParam objectForKey:@"numFieldOffsetY"] doubleValue] : 180;

  //登录按钮
  //[0]激活状态的图片；[1] 失效状态的图片；[2] 高亮状态的图片
  model.logBtnText = isExistKeyValue(modeParam,@"logBtnText") ? [modeParam objectForKey:@"logBtnText"] : @"一键登录";
  long logBtnTextHexColor = isExistKeyValue(modeParam,@"logBtnTextColor") ? [[modeParam objectForKey:@"logBtnTextColor"] longValue]: -1 ;
  model.logBtnTextColor = hexColor(logBtnTextHexColor);

  NSString * logBtnImgPath = isExistKeyValue(modeParam,@"logBtnImgPath") ? [modeParam objectForKey:@"logBtnImgPath"] : @"cmcc_login_btn_bg";

  UIImage *logBtnNormal = [UIImage imageNamed: [NSString stringWithFormat:@"%@%s", logBtnImgPath, "_normal"] ];
  UIImage *logBtnInvalied = [UIImage imageNamed: [NSString stringWithFormat:@"%@%s", logBtnImgPath, "_unable"] ];
  UIImage *logBtnHighted = [UIImage imageNamed: [NSString stringWithFormat:@"%@%s", logBtnImgPath, "_press"] ];
  model.logBtnImgs = @[logBtnNormal,logBtnInvalied,logBtnHighted];
  model.logBtnOffsetY = isExistKeyValue(modeParam,@"logBtnOffsetY") ? [[modeParam objectForKey:@"logBtnOffsetY"] doubleValue] : 254;

  //切换账号
  model.switchOffsetY = isExistKeyValue(modeParam,@"switchOffsetY") ? [[modeParam objectForKey:@"switchOffsetY"] doubleValue] : 300;
  model.swithAccHidden = isExistKeyValue(modeParam,@"switchAccHidden") ? [[modeParam objectForKey:@"switchAccHidden"] boolValue]: YES;
  long swithAccTextHexColor = isExistKeyValue(modeParam,@"switchAccTextColor")  ? [[modeParam objectForKey:@"switchAccTextColor"] longValue]: -108766 ;
  model.swithAccTextColor = hexColor(swithAccTextHexColor);

  //隐私条款
  if(isExistKeyValue(modeParam,@"clauseOneName")  && isExistKeyValue(modeParam,@"clauseOneUrl") ){
    model.appPrivacyOne = @[[modeParam objectForKey:@"clauseOneName"],[modeParam objectForKey:@"clauseOneUrl"]];
  }
  
  if(isExistKeyValue(modeParam,@"clauseTwoName") && isExistKeyValue(modeParam,@"clauseTwoUrl")){
    model.appPrivacyTwo = @[[modeParam objectForKey:@"clauseTwoName"],[modeParam objectForKey:@"clauseTwoUrl"]];
  }
  
  long clauseBaseHexColor = isExistKeyValue(modeParam,@"clauseColorBase") ? [[modeParam objectForKey:@"clauseColorBase"] longValue]: -10066330 ;
  long clauseHexColor = isExistKeyValue(modeParam,@"clauseColorAgree")  ? [[modeParam objectForKey:@"clauseColorAgree"] longValue]: -16007674 ;
  model.appPrivacyColor = @[hexColor(clauseBaseHexColor),hexColor(clauseHexColor)];

  model.uncheckedImg = [UIImage imageNamed:[modeParam objectForKey:@"uncheckedImgPath"]];
  model.checkedImg = [UIImage imageNamed:[modeParam objectForKey:@"checkedImgPath"]];
  model.privacyOffsetY = isExistKeyValue(modeParam,@"privacyOffsetY") ? [[modeParam objectForKey:@"privacyOffsetY"] doubleValue] : 30;
  model.privacyState = isExistKeyValue(modeParam,@"privacyState") ? [[modeParam objectForKey:@"privacyState"] boolValue]: NO;

  //授权页slogan
  long sloganTextHexColor = isExistKeyValue(modeParam,@"sloganTextColor") ? [[modeParam objectForKey:@"sloganTextColor"] longValue]: -10066330 ;
  model.sloganTextColor = hexColor(sloganTextHexColor);
  model.sloganOffsetY = isExistKeyValue(modeParam,@"sloganOffsetY") ? [[modeParam objectForKey:@"sloganOffsetY"] doubleValue] : 224;

  //短信验证码页面
  /**34、SDK短信验证码开关
   （默认为NO,不使用SDK提供的短验直接回调 ,YES:使用SDK提供的短验）
   为NO时,授权界面的切换账号按钮直接返回字典:200060 和 导航栏 “NavigationController”*/
  model.SMSAuthOn = isExistKeyValue(modeParam,@"useCmccSms") ? [[modeParam objectForKey:@"useCmccSms"] boolValue]: NO;

  NSString * smsNvText = isExistKeyValue(modeParam,@"smsNavText") ? [modeParam objectForKey:@"smsNavText"] : @"短信验证登录";
  model.SMSNavText = [[NSAttributedString alloc]initWithString:smsNvText attributes:@{}];
  model.SMSLogBtnText = [modeParam objectForKey:@"smsLogBtnText"];
  long smsLogBtnTextHexColor = isExistKeyValue(modeParam,@"smsLogBtnTextColor") ? [[modeParam objectForKey:@"smsLogBtnTextColor"] longValue]: -1 ;
  model.SMSLogBtnTextColor = hexColor(smsLogBtnTextHexColor);


  NSString * smsLogBtnImgPath = isExistKeyValue(modeParam,@"smsLogBtnImgPath") ? [modeParam objectForKey:@"smsLogBtnImgPath"] : @"cmcc_login_btn_bg";
  UIImage *smsLogBtnNormal = [UIImage imageNamed: [NSString stringWithFormat:@"%@%s", smsLogBtnImgPath, "_normal"] ];
  UIImage *smsLogBtnInvalied = [UIImage imageNamed: [NSString stringWithFormat:@"%@%s", smsLogBtnImgPath, "_unable"] ];
  UIImage *smsLogBtnHighted = [UIImage imageNamed: [NSString stringWithFormat:@"%@%s", smsLogBtnImgPath, "_press"] ];
  model.SMSLogBtnImgs = @[smsLogBtnNormal,smsLogBtnInvalied,smsLogBtnHighted];

  //设置短验页获取验证码按钮背景图片
  NSString * smsCodeImgPath = isExistKeyValue(modeParam,@"smsCodeImgPath") ? [modeParam objectForKey:@"smsCodeImgPath"] : @"cmcc_login_btn_bg";
  UIImage *smsCodeBtnNormal = [UIImage imageNamed: [NSString stringWithFormat:@"%@%s", smsCodeImgPath, "_normal"] ];
  UIImage *smsCodeBtnInvalied = [UIImage imageNamed: [NSString stringWithFormat:@"%@%s", smsCodeImgPath, "_unable"] ];
  UIImage *smsCodeBtnHighted = [UIImage imageNamed: [NSString stringWithFormat:@"%@%s", smsCodeImgPath, "_press"] ];
  model.SMSGetCodeBtnImgs = @[smsCodeBtnNormal,smsCodeBtnInvalied,smsCodeBtnHighted];

  ///设置短验页背景图片
  NSString * smsBGImgPath = isExistKeyValue(modeParam,@"smsBGImgPath") ? [modeParam objectForKey:@"smsBGImgPath"] : @"cmcc_root_bg";
  model.SMSBackgroundImage =  [UIImage imageNamed:smsBGImgPath];

  //授权界面自定义控件
  BOOL custBodyBtnHid = isExistKeyValue(modeParam,@"customBodyBtnHidden") ? [[modeParam objectForKey:@"customBodyBtnHidden"] boolValue]: YES;

  if(!custBodyBtnHid){
        model.authViewBlock = ^(UIView *customView){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
           [btn setTitle:[modeParam objectForKey:@"customBodyBtnText"] forState:UIControlStateNormal];
           btn.enabled = YES;
           btn.titleLabel.font = [UIFont systemFontOfSize:[[modeParam objectForKey:@"customBodyBtnTextSize"] intValue]];
           long customBodyBtnHexTextColor = isExistKeyValue(modeParam,@"customBodyBtnTextColor")  ? [[modeParam objectForKey:@"customBodyBtnTextColor"] longValue]: -108766 ;
           [btn setTitleColor:hexColor(customBodyBtnHexTextColor) forState:UIControlStateNormal];
           [btn addTarget:self action:@selector(customBodyAction) forControlEvents:UIControlEventTouchUpInside];

           CGRect screenBounds = [ [UIScreen mainScreen]bounds];
           btn.frame = CGRectMake(0, [[modeParam objectForKey:@"customBodyBtnOffsetY"] doubleValue], screenBounds.size.width-40, 100);
           CGPoint tmpPoint = btn.center;
           tmpPoint.x = screenBounds.size.width / 2;
           btn.center = tmpPoint;
           [customView addSubview:btn];
        };
  }

  return model;
}

/**
 *自定义按钮事件处理
 */
+ (void)customBodyAction{
    [UASDKLogin.shareLogin delectScrip];
    [_viewController dismissViewControllerAnimated:YES completion:nil];
    _result(@{@"resultCode":@"200020",@"btnType":BODY_BTN});
    
}

/**
 *自定义头按钮事件处理
 */
+(void)customTitleAction{
    [UASDKLogin.shareLogin delectScrip];
    [_viewController dismissViewControllerAnimated:YES completion:nil];
    _result(@{@"resultCode":@"200020",@"btnType":TITLE_BTN});
}

+(void)setTimeOut{
    NSTimeInterval reqTimeout = [[NSUserDefaults standardUserDefaults]integerForKey:@"TCMCC_REQTIMEOUT"] ;
    [UASDKLogin.shareLogin setTimeoutInterval:reqTimeout];
}

/**
* operatortype获取网络运营商: 0.未知 1.移动流量 2.联通流量网络 3.电信流量网络
* networktype 网络状态：0未知；1流量 2 wifi；3 数据流量+wifi
*/
#pragma mark --------------获取网络类型和运营商信息------------------
+ (void) getNetAndOprate:(FlutterResult)result {
    //result([TYRZUILogin networkType]);
    result([UASDKLogin.shareLogin networkInfo]);
}


#pragma mark --------------预取号------------------
+ (void) preGetphoneInfo:(FlutterResult)result {
  [self setTimeOut];
  [UASDKLogin.shareLogin getPhoneNumberCompletion:^(NSDictionary * _Nonnull sender) {
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithDictionary:sender];
    result(resultDict);
  }];
  /***
  NSTimeInterval reqTimeout = [[NSUserDefaults standardUserDefaults]integerForKey:@"TCMCC_REQTIMEOUT"];
  [TYRZUILogin getPhonenumberWithTimeout:reqTimeout completion:^(id sender) {
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithDictionary:sender];
    result(resultDict);
  }];
  */
}

#pragma mark --------------显示获取token------------------
+ (void) displayLogin:(UIViewController *)vc modeParam:(NSDictionary*)modeParam result:(FlutterResult)result {
    _viewController = vc;
    _result = result;
   [self setTimeOut];

    [UASDKLogin.shareLogin getAuthorizationWithModel:[self initWindowSytle:modeParam] complete:^(id  _Nonnull sender) {
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithDictionary:sender];
        [vc dismissViewControllerAnimated:YES completion:nil];
        result(resultDict);
    }];

    /***
    NSTimeInterval reqTimeout = [[NSUserDefaults standardUserDefaults]integerForKey:@"TCMCC_REQTIMEOUT"];
    [TYRZUILogin getAuthorizationWithController:vc timeout:reqTimeout complete:^(id sender) {
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithDictionary:sender];
        [vc dismissViewControllerAnimated:YES completion:nil];
        result(resultDict);
    }];*/
}

#pragma mark --------------隐式获取token------------------
+ (void) implicitLogin:(FlutterResult)result {
    [self setTimeOut];
    [UASDKLogin.shareLogin mobileAuthCompletion:^(NSDictionary * _Nonnull sender) {
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithDictionary:sender];
        result(resultDict);
    }];
    /***
    NSTimeInterval reqTimeout = [[NSUserDefaults standardUserDefaults]integerForKey:@"TCMCC_REQTIMEOUT"];
    [TYRZUILogin mobileAuthWithTimeout:reqTimeout complete:^(id sender) {
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithDictionary:sender];
        result(resultDict);
    }];*/
}

@end
