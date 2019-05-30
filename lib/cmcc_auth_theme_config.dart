import 'package:json_annotation/json_annotation.dart';

part 'cmcc_auth_theme_config.g.dart';

@JsonSerializable(nullable: false)
class CMCCAuthThemeConfig{
  ///授权页导航栏
  int navColor; ///设置导航栏颜色
  String navText; ///设置导航栏标题文字
  int navTextColor; ///设置导航栏标题文字颜色
  String navReturnImgPath;  ///设置导航栏返回按钮图标
  bool authNavTransparent; ///设置授权页导航栏透明 （5.6.5新增）
  ///授权页背景
  String authBGImgPath;  ///设置授权页背景图片（5.6.5新增）
  ///授权页logo
  String logoImgPath; ///设置logo图片
  int logoWidth;  ///设置logo宽度
  int logoHeight; ///设置logo高度
  int logoOffsetY; ///设置logo相对于标题栏下边缘y偏移
  int logoOffsetY_B; ///设置logo相对于底部y偏移（5.6.5新增）
  bool logoHidden;  ///隐藏logo
  ///授权页号码栏
  int numberColor;  ///设置手机号码字体颜色
  int numberSize;  ///设置号码栏字体大小（5.6.5新增）
  int numFieldOffsetY; ///设置号码栏相对于标题栏下边缘y偏移
  int numFieldOffsetY_B; ///设置号码栏相对于底部y偏移（5.6.5新增）
  ///授权页登录按钮
  String logBtnText; ///设置登录按钮文字
  int logBtnTextColor; ///设置登录按钮文字颜色
  String logBtnImgPath; ///设置授权登录按钮图片（5.6.5新增）
  int logBtnOffsetY; ///设置登录按钮相对于标题栏下边缘y偏移
  int logBtnOffsetY_B; ///设置登录按钮相对于底部y偏移
  ///切换账号
  bool switchAccHidden; ///隐藏“切换账号”
  int switchAccTextColor; ///设置切换账号字体颜色
  int switchOffsetY; ///设置切换账号相对于标题栏下边缘y偏移
  int switchOffsetY_B; ///设置切换账号相对于底部y偏移
  ///授权页隐私栏
  String clauseOneName; ///设置开发者隐私条款1名称和URL(名称，url)
  String clauseOneUrl;
  String clauseTwoName; ///设置开发者隐私条款2名称和URL(名称，url)
  String clauseTwoUrl;
  int clauseColorBase;  ///设置隐私条款名称颜色(基础文字颜色，协议文字颜色)
  int clauseColorAgree;
  String uncheckedImgPath; ///设置复选框未选中时图片
  String checkedImgPath;  ///设置复选框选中时图片
  int privacyOffsetY; ///设置隐私条款相对于标题栏下边缘y偏移
  int privacyOffsetY_B; ///设置隐私条款相对于底部y偏移
  bool privacyState;  ///协议是否默认勾选
  ///授权页slogan
  int sloganTextColor; ///设置移动slogan文字颜色
  int sloganOffsetY; ///设置slogan相对于标题栏下边缘y偏移
  int sloganOffsetY_B; ///设置slogan相对于底部y偏移
  ///短验页
  bool smsNavTransparent; ///设置短验页导航栏隐藏（5.6.5新增）
  String smsNavText;  ///设置短验页的导航栏标题文字
  String smsLogBtnText; ///设置短验页的登录按钮文字
  int smsLogBtnTextColor; ///设置短验页的按钮文字颜色
  String smsLogBtnImgPath; ///设置短验登录按钮图片
  String smsBGImgPath;  ///设置短验页背景图片（5.6.5新增）
  String smsCodeImgPath; ///设置短验页获取验证码按钮背景图片（5.6.5新增）
  int  smsCodeBtnTextColor; ///设置短验页获取验证码按钮文字颜色
  int  smsSloganTextColor; ///设置短验页slogan文字颜色
  ///自定义控件 授权页面允许开发者在授权页面titlebar和body添加自定义的控件
  String customTitleBtnText;
  int customTitleBtnTextColor;
  int customTitleBtnTextSize;
  bool customTitleBtnHidden;
  String customBodyBtnText;
  int customBodyBtnTextColor;
  int customBodyBtnTextSize;
  bool customBodyBtnHidden;
  int customBodyBtnOffsetY;
  bool cmccDebug;
  bool useCmccSms;

  CMCCAuthThemeConfig({
    int navColor : -16742704,
    String navText : "统一认证登录",
    int navTextColor : -1,
    String navReturnImgPath : "cmcc_return_bg",
    bool authNavTransparent : false,
    String authBGImgPath : "cmcc_root_bg",
    String logoImgPath : "cmcc_login_logo",
    int logoWidth : 70,
    int logoHeight : 70,
    int logoOffsetY : 100,
    int logoOffsetY_B : 0,
    bool logoHidden : false,
    int numberColor : -16742704,
    int numberSize : 18,
    int numFieldOffsetY : 184,
    int numFieldOffsetY_B : 0,
    String logBtnText : "本机号码一键登录",
    int logBtnTextColor : -1,
    String logBtnImgPath : "cmcc_login_btn_bg",
    int logBtnOffsetY : 254,
    int logBtnOffsetY_B : 0,
    bool switchAccHidden:false,
    int switchAccTextColor : -11365671,
    int switchOffsetY : 300,
    int switchOffsetY_B : 0,
    String clauseOneName,
    String clauseOneUrl,
    String clauseTwoName,
    String clauseTwoUrl,
    int clauseColorBase : -10066330,
    int clauseColorAgree : -16007674,
    String uncheckedImgPath : "cmcc_uncheck_image",
    String checkedImgPath : "cmcc_check_image",
    int privacyOffsetY : 0,
    int privacyOffsetY_B : 30,
    bool privacyState : false,
    int sloganTextColor : -10066330,
    int sloganOffsetY : 224,
    int sloganOffsetY_B : 0,
    bool smsNavTransparent : false,
    String smsNavText : "短信验证登录",
    String smsLogBtnText : "短信验证码登录",
    int smsLogBtnTextColor : -1,
    String smsLogBtnImgPath : "cmcc_login_btn_bg",
    String smsBGImgPath : "cmcc_root_bg",
    String smsCodeImgPath : "cmcc_get_smscode_btn_bg",
    int smsCodeBtnTextColor : -1,
    int smsSloganTextColor : -1,
    String customTitleBtnText : "其它",
    int customTitleBtnTextColor : -1,
    int customTitleBtnTextSize : 15,
    bool customTitleBtnHidden : true,
    String customBodyBtnText : "其它方式登录",
    int customBodyBtnTextColor : -60338,
    int customBodyBtnTextSize : 13,
    bool customBodyBtnHidden : true,
    int customBodyBtnOffsetY : 450,
    bool cmccDebug : true,
    bool useCmccSms : false
  }){
    this.navColor=              navColor;
    this.navText=               navText;
    this.navTextColor=          navTextColor;
    this.navReturnImgPath=      navReturnImgPath;
    this.authNavTransparent =   authNavTransparent;
    this.authBGImgPath=         authBGImgPath;
    this.logoImgPath=           logoImgPath;
    this.logoWidth=             logoWidth;
    this.logoHeight=            logoHeight;
    this.logoOffsetY=           logoOffsetY;
    this.logoOffsetY_B=         logoOffsetY_B;
    this.logoHidden=            logoHidden;
    this.numberColor=           numberColor;
    this.numberSize=            numberSize;
    this.numFieldOffsetY=       numFieldOffsetY;
    this.numFieldOffsetY_B=     numFieldOffsetY_B;
    this.logBtnText=            logBtnText;
    this.logBtnTextColor=       logBtnTextColor;
    this.logBtnImgPath=         logBtnImgPath;
    this.logBtnOffsetY=         logBtnOffsetY;
    this.logBtnOffsetY_B=       logBtnOffsetY_B;
    this.switchAccHidden=       switchAccHidden;
    this.switchAccTextColor=    switchAccTextColor;
    this.switchOffsetY=         switchOffsetY;
    this.switchOffsetY_B=       switchOffsetY_B;
    this.numFieldOffsetY=       numFieldOffsetY;
    this.clauseOneName=         clauseOneName;
    this.clauseOneUrl=          clauseOneUrl;
    this.clauseTwoName=         clauseTwoName;
    this.clauseTwoUrl=          clauseTwoUrl;
    this.clauseColorBase=       clauseColorBase;
    this.clauseColorAgree=      clauseColorAgree;
    this.uncheckedImgPath=      uncheckedImgPath;
    this.checkedImgPath=        checkedImgPath;
    this.privacyOffsetY=        privacyOffsetY;
    this.privacyOffsetY_B=      privacyOffsetY_B;
    this.privacyState=          privacyState;
    this.sloganTextColor=       sloganTextColor;
    this.sloganOffsetY=         sloganOffsetY;
    this.sloganOffsetY_B=       sloganOffsetY_B;
    this.smsNavTransparent=     smsNavTransparent;
    this.smsNavText=            smsNavText;
    this.smsLogBtnText=         smsLogBtnText;
    this.smsLogBtnTextColor=    smsLogBtnTextColor;
    this.smsLogBtnImgPath  =    smsLogBtnImgPath;
    this.smsBGImgPath  =        smsBGImgPath;
    this.smsCodeImgPath  =      smsCodeImgPath;
    this.smsCodeBtnTextColor=   smsCodeBtnTextColor;
    this.smsSloganTextColor=    smsSloganTextColor;
    this.customTitleBtnText =   customTitleBtnText;
    this.customTitleBtnTextColor = customTitleBtnTextColor;
    this.customTitleBtnTextSize = customTitleBtnTextSize;
    this.customTitleBtnHidden = customTitleBtnHidden;
    this.customBodyBtnText =  customBodyBtnText;
    this.customBodyBtnTextColor = customBodyBtnTextColor;
    this.customBodyBtnTextSize = customBodyBtnTextSize;
    this.customBodyBtnHidden = customBodyBtnHidden;
    this.customBodyBtnOffsetY = customBodyBtnOffsetY;
    this.cmccDebug = cmccDebug;
    this.useCmccSms = useCmccSms;
  }

  factory CMCCAuthThemeConfig.fromJson(Map<String, dynamic> json) => _$CMCCAuthThemeConfigFromJson(json);

  Map<String, dynamic> toJson() => _$CMCCAuthThemeConfigToJson(this);
}
