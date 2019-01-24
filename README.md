## flutter_cmcc_auth

## 移动认证 一键登录 本地号码验证的 Flutter plugin.

## 插件地址 [ https://github.com/woguava/flutter_cmcc_auth.git ]
## 支持 Android and iOS.

## Examples

## 在flutter的  main.dart  中设置移动认证相关参数，并进行注册

  void initState() {
    super.initState();
    if(Platform.isIOS){
      _cmccAppId = '300011880083';
      _cmccAppKey = '9DC5CE24E4AAD5603CE62F7D927BBFCC';
    }else if(Platform.isAndroid){
      _cmccAppId = '300011880217';
      _cmccAppKey = 'EC8135B461F93A0160ADF31F9AE111EF';
    }
    _cmccTimeout = 8000;
    CMCCAuthOptions opt = new CMCCAuthOptions(_cmccAppId,_cmccAppKey,expiresln:_cmccTimeout);
    FlutterCmccAuth.setMobileAuthOptions(opt);

    initCMCCSDK();
  }

  Future<void> initCMCCSDK() async {
    await FlutterCmccAuth.mobileRegister;
  }

##设置授权页面主题

  CMCCAuthThemeConfig themeconfig = new CMCCAuthThemeConfig(
                      navColor : -108766,
                      navText : "统一认证登录",
                      navTextColor : -1,
                      navReturnImgPath : "cmcc_return_bg",
                      logoImgPath : 'cmcc_login_logo',
                      logoWidth : 120,
                      logoHeight : 80,
                      logoOffsetY : 100,
                      logoHidden : false,
                      numberColor : -108766,
                      switchAccHidden:false,
                      switchAccTextColor : -108766,
                      switchAccOffsetY : 300,
                      numFieldOffsetY : 180,
                      logBtnText : "本机号码一键登录",
                      logBtnOffsetY : 254,
                      logBtnTextColor : -1,
                      logBtnBackgroundPath : "cmcc_login_btn_bg",
                      uncheckedImgPath : "cmcc_uncheck_image",
                      checkedImgPath : "cmcc_check_image",
                      privacyOffsetY : 25,
                      clauseName : '应用自定义服务条款一',
                      clauseUrl : 'http://www.baidu.com',
                      clauseBaseColor : -10066330,
                      clauseColor : -16007674,
                      clauseNameTwo : '应用自定义服务条款二',
                      clauseUrlTwo : 'http://www.sina.com',
                      sloganOffsetY : 224,
                      sloganTextColor : -10066330,
                      smsNavText : "短信验证登录",
                      smsLogBtnText : "短信验证码登录",
                      smsLogBtnTextColor : -1,
                      smsLogBtnImgPath : "cmcc_login_btn_bg",
                      customTitleBtnText : "其它",
                      customTitleBtnTextColor : -1,
                      customTitleBtnTextSize : 15,
                      customTitleBtnHidden : false,
                      customBodyBtnText : "其它方式登录",
                      customBodyBtnTextColor : -108766,
                      customBodyBtnTextSize : 15,
                      customBodyBtnHidden : false,
                      customBodyBtnOffsetY: 320,
                      cmccDebug: false,
                      useCmccSms: false);
   await FlutterCmccAuth.authThemeConfig(themeconfig);

   # *** 设置授权页面主题 Android 说明 ***
   需要在 Android 项目下 res/drawable 中添加相关的 png 图片资源
   图片资源的名称与配置对应，如上面的显示logo配置
         logoImgPath : 'cmcc_login_logo',
   对应  
         res/drawable/cmcc_login_logo.png

   # *** 设置授权页面主题 IOS 说明 ***
   需要在 ios 项目下 Assets.xcassets 中添加相关的 png 图片资源
   图片资源的名称与配置对应，如上面的显示logo配置
         logoImgPath : 'cmcc_login_logo',
   对应
         Assets.xcassets/cmcc_login_logo.imageset/cmcc_login_logo.png 
         Assets.xcassets/cmcc_login_logo.imageset/Contents.json

   ##预取号
   CMCCMobileAuthResult result = await FlutterCmccAuth.preGetphoneInfo;

   ##授权登录
   CMCCMobileAuthResult result = await FlutterCmccAuth.displayLogin;

   ##号码校验
   CMCCMobileAuthResult result = await FlutterCmccAuth.implicitLogin;

