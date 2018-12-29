import 'package:json_annotation/json_annotation.dart';

part 'cmcc_auth_theme_config.g.dart';

@JsonSerializable()
class CMCCAuthThemeConfig{
  int navColor;
  String navText;
  int navTextColor;
  String navReturnImgPath;
  String logoImgPath;
  int logoWidth;
  int logoHeight;
  int logoOffsetY;
  bool logoHidden;
  int numberColor;
  bool switchAccHidden;
  int switchAccTextColor;
  int switchAccOffsetY;
  int numFieldOffsetY;
  String logBtnText;
  int logBtnOffsetY;
  int logBtnTextColor;
  String logBtnBackgroundPath;
  String uncheckedImgPath;
  String checkedImgPath;
  int privacyOffsetY;
  String clauseName;
  String clauseUrl;
  int clauseBaseColor;
  int clauseColor;
  String clauseNameTwo;
  String clauseUrlTwo;
  int sloganOffsetY;
  int sloganTextColor;
  String smsNavText;
  String smsLogBtnText;
  int smsLogBtnTextColor;
  String smsLogBtnImgPath;
  String customTitleBtnText;
  int customTitleBtnTextColor;
  int customTitleBtnTextSize;
  bool customTitleBtnHidden;
  String customBodyBtnText;
  int customBodyBtnTextColor;
  int customBodyBtnTextSize;
  bool customBodyBtnHidden;
  int customBodyBtnOffsetY;

  CMCCAuthThemeConfig({
    int navColor : -16742704,
    String navText : "登录",
    int navTextColor : -1,
    String navReturnImgPath : "return_bg",
    String logoImgPath : "mobile_logo",
    int logoWidth : 70,
    int logoHeight : 70,
    int logoOffsetY : 100,
    bool logoHidden : false,
    int numberColor : -16742704,
    bool switchAccHidden:false,
    int switchAccTextColor : -11365671,
    int switchAccOffsetY : 300,
    int numFieldOffsetY : 184,
    String logBtnText : "本机号码一键登录",
    int logBtnOffsetY : 254,
    int logBtnTextColor : -1,
    String logBtnBackgroundPath : "umcsdk_login_btn_bg",
    String uncheckedImgPath : "uncheck_image",
    String checkedImgPath : "check_image",
    int privacyOffsetY : 30,
    String clauseName,
    String clauseUrl,
    int clauseBaseColor : -10066330,
    int clauseColor : -16007674,
    String clauseNameTwo,
    String clauseUrlTwo,
    int sloganOffsetY : 224,
    int sloganTextColor : -10066330,
    String smsNavText : "登录",
    String smsLogBtnText : "短信验证码登录",
    int smsLogBtnTextColor : -1,
    String smsLogBtnImgPath : "umcsdk_login_btn_bg",
    String customTitleBtnText : "其它",
    int customTitleBtnTextColor : -1,
    int customTitleBtnTextSize : 15,
    bool customTitleBtnHidden : true,
    String customBodyBtnText : "其它方式登录",
    int customBodyBtnTextColor : -60338,
    int customBodyBtnTextSize : 13,
    bool customBodyBtnHidden : true,
    int customBodyBtnOffsetY : 450
  }){
    this.navColor=              navColor;
    this.navText=               navText;
    this.navTextColor=          navTextColor;
    this.navReturnImgPath=      navReturnImgPath;
    this.logoImgPath=           logoImgPath;
    this.logoWidth=             logoWidth;
    this.logoHeight=            logoHeight;
    this.logoOffsetY=           logoOffsetY;
    this.logoHidden=            logoHidden;
    this.numberColor=           numberColor;
    this.switchAccHidden=       switchAccHidden;
    this.switchAccTextColor=    switchAccTextColor;
    this.switchAccOffsetY=      switchAccOffsetY;
    this.numFieldOffsetY=       numFieldOffsetY;
    this.logBtnText=            logBtnText;
    this.logBtnOffsetY=         logBtnOffsetY;
    this.logBtnTextColor=       logBtnTextColor;
    this.logBtnBackgroundPath=  logBtnBackgroundPath;
    this.uncheckedImgPath=      uncheckedImgPath;
    this.checkedImgPath=        checkedImgPath;
    this.privacyOffsetY=        privacyOffsetY;
    this.clauseName=            clauseName;
    this.clauseUrl=             clauseUrl;
    this.clauseBaseColor=       clauseBaseColor;
    this.clauseColor=           clauseColor;
    this.clauseNameTwo=         clauseNameTwo;
    this.clauseUrlTwo=          clauseUrlTwo;
    this.sloganOffsetY=         sloganOffsetY;
    this.sloganTextColor=       sloganTextColor;
    this.smsNavText=            smsNavText;
    this.smsLogBtnText=         smsLogBtnText;
    this.smsLogBtnTextColor=    smsLogBtnTextColor;
    this.smsLogBtnImgPath  =     smsLogBtnImgPath;
    this.customTitleBtnText = customTitleBtnText;
    this.customTitleBtnTextColor = customTitleBtnTextColor;
    this.customTitleBtnTextSize = customTitleBtnTextSize;
    this.customTitleBtnHidden = customTitleBtnHidden;
    this.customBodyBtnText =  customBodyBtnText;
    this.customBodyBtnTextColor = customBodyBtnTextColor;
    this.customBodyBtnTextSize = customBodyBtnTextSize;
    this.customBodyBtnHidden = customBodyBtnHidden;
    this.customBodyBtnOffsetY = customBodyBtnOffsetY;
  }

  factory CMCCAuthThemeConfig.fromJson(Map<String, dynamic> json) => _$CMCCAuthThemeConfigFromJson(json);

  Map<String, dynamic> toJson() => _$CMCCAuthThemeConfigToJson(this);
}
