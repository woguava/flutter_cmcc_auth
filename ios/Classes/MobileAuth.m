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
  [TYRZUILogin initializeWithAppId:appId appKey:appKey];
}

+ (void) initWindowSytle:(NSDictionary*)modeParam {
  //是否打印日志
  BOOL  cmccDebug = isExistKeyValue(modeParam,@"cmccDebug") ? [[modeParam objectForKey:@"cmccDebug"] boolValue]: NO;
  [TYRZUILogin printConsoleEnable:cmccDebug];
  // 自定义短信验证码开关
  BOOL useCmccSms = isExistKeyValue(modeParam,@"useCmccSms") ? [[modeParam objectForKey:@"useCmccSms"] boolValue]: NO;
  [TYRZUILogin enableCustomSMS:useCmccSms];
  
  UACustomModel *model = [[UACustomModel alloc]init];

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
  model.barStyle = 0;
  NSString * navRtnImgPath = isExistKeyValue(modeParam,@"navReturnImgPath") ? [modeParam objectForKey:@"navReturnImgPath"] : @"cmcc_return_bg";
  model.navReturnImg =  [UIImage imageNamed:navRtnImgPath];
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
  model.oldStyle = NO;
  long numberHexColor = isExistKeyValue(modeParam,@"numberColor") ? [[modeParam objectForKey:@"numberColor"] longValue]:  -108766 ;
  model.numberColor = hexColor(numberHexColor);
  model.numFieldOffsetY = isExistKeyValue(modeParam,@"numFieldOffsetY") ? [[modeParam objectForKey:@"numFieldOffsetY"] doubleValue] : 180;

  //登录按钮
  //[0]激活状态的图片；[1] 失效状态的图片；[2] 高亮状态的图片
  model.logBtnText = isExistKeyValue(modeParam,@"logBtnText") ? [modeParam objectForKey:@"logBtnText"] : @"一键登录";
  long logBtnTextHexColor = isExistKeyValue(modeParam,@"logBtnTextColor") ? [[modeParam objectForKey:@"logBtnTextColor"] longValue]: -1 ;
  model.logBtnTextColor = hexColor(logBtnTextHexColor);

  UIImage *logBtnNormal = [UIImage imageNamed: isExistKeyValue(modeParam,@"logBtnImgNormal") ? [modeParam objectForKey:@"logBtnImgNormal"] : @"cmcc_login_btn_normal" ];
  UIImage *logBtnInvalied = [UIImage imageNamed: isExistKeyValue(modeParam,@"logBtnImgInvalied") ? [modeParam objectForKey:@"logBtnImgInvalied"] : @"cmcc_login_btn_unable"];
  UIImage *logBtnHighted = [UIImage imageNamed: isExistKeyValue(modeParam,@"logBtnImgHighted") ? [modeParam objectForKey:@"logBtnImgHighted"] : @"cmcc_login_btn_press"];
  model.logBtnImgs = @[logBtnNormal,logBtnInvalied,logBtnHighted];
  model.logBtnOffsetY = isExistKeyValue(modeParam,@"logBtnOffsetY") ? [[modeParam objectForKey:@"logBtnOffsetY"] doubleValue] : 254;

  //切换账号
  model.switchOffsetY = isExistKeyValue(modeParam,@"switchAccOffsetY") ? [[modeParam objectForKey:@"switchAccOffsetY"] doubleValue] : 300;
  model.swithAccHidden = isExistKeyValue(modeParam,@"switchAccHidden") ? [[modeParam objectForKey:@"switchAccHidden"] boolValue]: YES;
  long swithAccTextHexColor = isExistKeyValue(modeParam,@"switchAccTextColor")  ? [[modeParam objectForKey:@"switchAccTextColor"] longValue]: -108766 ;
  model.swithAccTextColor = hexColor(swithAccTextHexColor);

  //隐私条款
  if(isExistKeyValue(modeParam,@"clauseName")  && isExistKeyValue(modeParam,@"clauseUrl") ){
    model.appPrivacyOne = @[[modeParam objectForKey:@"clauseName"],[modeParam objectForKey:@"clauseUrl"]];
  }
  
  if(isExistKeyValue(modeParam,@"clauseNameTwo") && isExistKeyValue(modeParam,@"clauseUrlTwo")){
    model.appPrivacyTow = @[[modeParam objectForKey:@"clauseNameTwo"],[modeParam objectForKey:@"clauseUrlTwo"]];
  }
  
  long clauseBaseHexColor = isExistKeyValue(modeParam,@"clauseBaseColor") ? [[modeParam objectForKey:@"clauseBaseColor"] longValue]: -10066330 ;
  long clauseHexColor = isExistKeyValue(modeParam,@"clauseColor")  ? [[modeParam objectForKey:@"clauseColor"] longValue]: -16007674 ;
  model.appPrivacyColor = @[hexColor(clauseBaseHexColor),hexColor(clauseHexColor)];

  model.uncheckedImg = [UIImage imageNamed:[modeParam objectForKey:@"uncheckedImgPath"]];
  model.checkedImg = [UIImage imageNamed:[modeParam objectForKey:@"checkedImgPath"]];
  model.privacyOffsetY = isExistKeyValue(modeParam,@"privacyOffsetY") ? [[modeParam objectForKey:@"privacyOffsetY"] doubleValue] : 30;

  //授权页slogan
  long sloganTextHexColor = isExistKeyValue(modeParam,@"sloganTextColor") ? [[modeParam objectForKey:@"sloganTextColor"] longValue]: -10066330 ;
  model.sloganTextColor = hexColor(sloganTextHexColor);
  model.sloganOffsetY = isExistKeyValue(modeParam,@"sloganOffsetY") ? [[modeParam objectForKey:@"sloganOffsetY"] doubleValue] : 224;

  //短信验证码页面
  NSString * smsNvText = isExistKeyValue(modeParam,@"smsNavText") ? [modeParam objectForKey:@"smsNavText"] : @"短信验证登录";
  model.SMSNavText = [[NSAttributedString alloc]initWithString:smsNvText attributes:@{}];
  model.SMSLogBtnText = [modeParam objectForKey:@"smsLogBtnText"];
  long smsLogBtnTextHexColor = isExistKeyValue(modeParam,@"smsLogBtnTextColor") ? [[modeParam objectForKey:@"smsLogBtnTextColor"] longValue]: -1 ;
  model.SMSLogBtnTextColor = hexColor(smsLogBtnTextHexColor);

  UIImage *smsLogBtnNormal = [UIImage imageNamed:isExistKeyValue(modeParam,@"smsLogBtnImgNormal") ? [modeParam objectForKey:@"smsLogBtnImgNormal"] : @"cmcc_login_btn_normal" ];
  UIImage *smsLogBtnInvalied = [UIImage imageNamed:isExistKeyValue(modeParam,@"smsLogBtnImgInvalied") ? [modeParam objectForKey:@"smsLogBtnImgInvalied"] : @"cmcc_login_btn_unable"];
  UIImage *smsLogBtnHighted = [UIImage imageNamed:isExistKeyValue(modeParam,@"smsLogBtnImgHighted") ? [modeParam objectForKey:@"smsLogBtnImgHighted"] : @"cmcc_login_btn_press" ];
  model.SMSLogBtnImgs = @[smsLogBtnNormal,smsLogBtnInvalied,smsLogBtnHighted];
  

  [TYRZUILogin customUIWithParams:model customViews:^(UIView *customAreaView) {
      BOOL custBodyBtnHid = isExistKeyValue(modeParam,@"customBodyBtnHidden") ? [[modeParam objectForKey:@"customBodyBtnHidden"] boolValue]: YES;
      
      if(!custBodyBtnHid){
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
          [customAreaView addSubview:btn];
      }
  }];
  
}

/**
 *自定义按钮事件处理
 */
+ (void)customBodyAction{
    [_viewController dismissViewControllerAnimated:YES completion:nil];
    _result(@{@"resultCode":@"000000",@"btnType":BODY_BTN});
}

/**
 *自定义头按钮事件处理
 */
+(void)customTitleAction{
    [_viewController dismissViewControllerAnimated:YES completion:nil];
    _result(@{@"resultCode":@"000000",@"btnType":TITLE_BTN});
}


/**
* operatortype获取网络运营商: 0.未知 1.移动流量 2.联通流量网络 3.电信流量网络
* networktype 网络状态：0未知；1流量 2 wifi；3 数据流量+wifi
*/
#pragma mark --------------获取网络类型和运营商信息------------------
+ (void) getNetAndOprate:(FlutterResult)result {
    result([TYRZUILogin networkType]);
}


#pragma mark --------------预取号------------------
+ (void) preGetphoneInfo:(FlutterResult)result {
   NSTimeInterval reqTimeout = [[NSUserDefaults standardUserDefaults]integerForKey:@"TCMCC_REQTIMEOUT"] ;
  [TYRZUILogin getPhonenumberWithTimeout:reqTimeout completion:^(id sender) {
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithDictionary:sender];
    result(resultDict);
  }];
}

#pragma mark --------------显示获取token------------------
+ (void) displayLogin:(UIViewController *)vc  result:(FlutterResult)result {
    _viewController = vc;
    _result = result;
    NSTimeInterval reqTimeout = [[NSUserDefaults standardUserDefaults]integerForKey:@"TCMCC_REQTIMEOUT"];
    [TYRZUILogin getAuthorizationWithController:vc timeout:reqTimeout complete:^(id sender) {
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithDictionary:sender];
        [vc dismissViewControllerAnimated:YES completion:nil];
        result(resultDict);
    }];
}

#pragma mark --------------隐式获取token------------------
+ (void) implicitLogin:(FlutterResult)result {
    NSTimeInterval reqTimeout = [[NSUserDefaults standardUserDefaults]integerForKey:@"TCMCC_REQTIMEOUT"];
    [TYRZUILogin mobileAuthWithTimeout:reqTimeout complete:^(id sender) {
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithDictionary:sender];
        result(resultDict);
    }];
}

@end
