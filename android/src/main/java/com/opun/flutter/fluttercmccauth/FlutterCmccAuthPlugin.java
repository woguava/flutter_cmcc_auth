package com.opun.flutter.fluttercmccauth;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.cmic.sso.sdk.AuthThemeConfig;

/** FlutterCmccAuthPlugin */
public class FlutterCmccAuthPlugin implements MethodCallHandler {
  private final Registrar registrar;
  private final  PermissionManager permissionManager;
  private final MobileAuth mobileAuth;

  private FlutterCmccAuthPlugin(Registrar registrar){
    this.registrar = registrar;
    this.permissionManager = new PermissionManager(registrar.activity());
    registrar.addRequestPermissionsResultListener(permissionManager);
    mobileAuth = new MobileAuth(registrar.activity());
  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_cmcc_auth");
    channel.setMethodCallHandler(new FlutterCmccAuthPlugin(registrar));
  }

  private boolean initPlugin(MethodCall call, Result result){
    if (call.method.equals("mobileRegister")) {
      String appId = call.argument("appId");
      String appkey = call.argument("appkey");
      int expiresln = 8000;
      if(null != call.argument("expiresln")){
        expiresln = call.argument("expiresln");
      }
      mobileAuth.initSDK(appId,appkey,expiresln);
      result.success("sucess");
      return  true;
    }
    return false;
  }

  private boolean setMobileAuthThemeConfig(MethodCall call, Result result){
    if (call.method.equals("displayLogin")) {
      ///授权页导航栏
      Number navColor = -1;
      if(null != call.argument("navColor")){
        navColor = call.argument("navColor");
      }
      String navText = call.argument("navText");
      Number navTextColor = -1;
      if(null != call.argument("navTextColor")){
        navTextColor = call.argument("navTextColor");
      }
      String navReturnImgPath = call.argument("navReturnImgPath");
      boolean authNavTransparent = false;
      if(null != call.argument("authNavTransparent")) {
        authNavTransparent = call.argument("authNavTransparent");
      }
      ///授权页背景
      String authBGImgPath = call.argument("authBGImgPath");
      ///授权页logo
      String logoImgPath = call.argument("logoImgPath");
      int logoWidth = 70;
      if(null != call.argument("logoWidth")){
        logoWidth = call.argument("logoWidth");
      }
      int logoHeight = 70;
      if(null != call.argument("logoHeight")){
        logoHeight = call.argument("logoHeight");
      }
      int logoOffsetY = 100;
      if(null != call.argument("logoOffsetY")){
        logoOffsetY = call.argument("logoOffsetY");
      }
      int logoOffsetY_B = 0;
      if(null != call.argument("logoOffsetY_B")){
        logoOffsetY_B = call.argument("logoOffsetY_B");
      }
      boolean logoHidden = false;
      if(null != call.argument("logoHidden")) {
        logoHidden = call.argument("logoHidden");
      }
      ///授权页号码栏
      Number numberColor = -1;
      if(null != call.argument("numberColor")) {
        numberColor = call.argument("numberColor");
      }
      int numberSize = 18;
      if(null != call.argument("numberSize")) {
        numberSize = call.argument("numberSize");
      }
      int numFieldOffsetY = 184;
      if(null != call.argument("numFieldOffsetY")){
        numFieldOffsetY = call.argument("numFieldOffsetY");
      }
      int numFieldOffsetY_B = 0;
      if(null != call.argument("numFieldOffsetY_B")){
        numFieldOffsetY_B = call.argument("numFieldOffsetY_B");
      }

      ///授权页登录按钮
      String logBtnText = call.argument("logBtnText");
      Number logBtnTextColor = -1;
      if(null != call.argument("logBtnTextColor")) {
        logBtnTextColor = call.argument("logBtnTextColor");
      }
      String logBtnImgPath = call.argument("logBtnImgPath");
      int logBtnOffsetY = 254;
      if(null != call.argument("logBtnOffsetY")) {
        logBtnOffsetY = call.argument("logBtnOffsetY");
      }
      int logBtnOffsetY_B = 0;
      if(null != call.argument("logBtnOffsetY_B")) {
        logBtnOffsetY_B = call.argument("logBtnOffsetY_B");
      }

      ///切换账号
      boolean switchAccHidden = false;
      if(null != call.argument("switchAccHidden")) {
        switchAccHidden = call.argument("switchAccHidden");
      }
      Number switchAccTextColor = -1;
      if(null != call.argument("switchAccTextColor")) {
        switchAccTextColor = call.argument("switchAccTextColor");
      }
      int switchOffsetY = 300;
      if(null != call.argument("switchOffsetY")){
        switchOffsetY = call.argument("switchOffsetY");
      }
      int switchOffsetY_B = 0;
      if(null != call.argument("switchOffsetY_B")){
        switchOffsetY_B = call.argument("switchOffsetY_B");
      }

      ///授权页隐私栏
      String clauseOneName = call.argument("clauseOneName");
      String clauseOneUrl = call.argument("clauseOneUrl");
      String clauseTwoName = call.argument("clauseTwoName");
      String clauseTwoUrl = call.argument("clauseTwoUrl");
      Number clauseColorBase = -10066330;
      if(null != call.argument("clauseColorBase")) {
        clauseColorBase = call.argument("clauseColorBase");
      }
      Number clauseColorAgree = -16007674;
      if (null != call.argument("clauseColorAgree")) {
        clauseColorAgree = call.argument("clauseColorAgree");
      }
      String uncheckedImgPath = call.argument("uncheckedImgPath");
      String checkedImgPath = call.argument("checkedImgPath");
      int privacyOffsetY = 0;
      if(null != call.argument("privacyOffsetY")) {
        privacyOffsetY = call.argument("privacyOffsetY");
      }
      int privacyOffsetY_B = 30;
      if(null != call.argument("privacyOffsetY_B")) {
        privacyOffsetY_B = call.argument("privacyOffsetY_B");
      }
      boolean privacyState = false;
      if(null != call.argument("privacyState")) {
        privacyState = call.argument("privacyState");
      }


      ///授权页slogan
      Number sloganTextColor = -16007674L;
      if(null != call.argument("sloganTextColor")) {
        sloganTextColor = call.argument("sloganTextColor");
      }
      int sloganOffsetY = 224;
      if (null != call.argument("sloganOffsetY")) {
        sloganOffsetY = call.argument("sloganOffsetY");
      }
      int sloganOffsetY_B = 0;
      if (null != call.argument("sloganOffsetY_B")) {
        sloganOffsetY_B = call.argument("sloganOffsetY_B");
      }

      ///短验页
      boolean smsNavTransparent = false;
      if(null != call.argument("smsNavTransparent")) {
        smsNavTransparent = call.argument("smsNavTransparent");
      }
      String smsNavText = call.argument("smsNavText");
      String smsLogBtnText = call.argument("smsLogBtnText");
      Number smsLogBtnTextColor = -1;
      if(null != call.argument("smsLogBtnTextColor")) {
        smsLogBtnTextColor = call.argument("smsLogBtnTextColor");
      }
      String smsLogBtnImgPath = call.argument("smsLogBtnImgPath");
      String smsBGImgPath = call.argument("smsBGImgPath");
      String smsCodeImgPath = call.argument("smsCodeImgPath");
      Number smsCodeBtnTextColor = -1;
      if(null != call.argument("smsCodeBtnTextColor")) {
        smsCodeBtnTextColor = call.argument("smsCodeBtnTextColor");
      }
      Number smsSloganTextColor = -1;
      if(null != call.argument("smsSloganTextColor")) {
        smsSloganTextColor = call.argument("smsSloganTextColor");
      }

      ///自定义控件 授权页面允许开发者在授权页面titlebar和body添加自定义的控件
      String customTitleBtnText = call.argument("customTitleBtnText");
      Number customTitleBtnTextColor = -1;
      if(null != call.argument("customTitleBtnTextColor")) {
        customTitleBtnTextColor = call.argument("customTitleBtnTextColor") ;
      }
      int customTitleBtnTextSize = 14;
      if(null != call.argument("customTitleBtnTextSize")) {
        customTitleBtnTextSize = call.argument("customTitleBtnTextSize");
      }
      boolean customTitleBtnHidden = true;
      if(null != call.argument("customTitleBtnHidden")) {
        customTitleBtnHidden = call.argument("customTitleBtnHidden");
      }

      String customBodyBtnText = call.argument("customBodyBtnText");
      Number customBodyBtnTextColor = -1;
      if(null != call.argument("customBodyBtnTextColor")) {
        customBodyBtnTextColor = call.argument("customBodyBtnTextColor") ;
      }
      int customBodyBtnTextSize = 13;
      if(null != call.argument("customBodyBtnTextSize")) {
        customBodyBtnTextSize = call.argument("customBodyBtnTextSize");
      }
      boolean customBodyBtnHidden = true;
      if(null != call.argument("customBodyBtnHidden")) {
        customBodyBtnHidden = call.argument("customBodyBtnHidden");
      }

      int customBodyBtnOffsetY = 450;
      if(null != call.argument("customBodyBtnOffsetY")){
        customBodyBtnOffsetY = call.argument("customBodyBtnOffsetY");
      }

      boolean cmccDebug = false;
      if(null != call.argument("cmccDebug")) {
        cmccDebug = call.argument("cmccDebug");
      }
      boolean useCmccSms = false;
      if(null != call.argument("useCmccSms")) {
        useCmccSms = call.argument("useCmccSms");
      }


      mobileAuth.initDynamicButton(
              new MobileCustomButton(registrar.activeContext(),1,customTitleBtnText,customTitleBtnTextColor.intValue(),customTitleBtnTextSize,0),
              new MobileCustomButton(registrar.activeContext(),2,customBodyBtnText,customBodyBtnTextColor.intValue(),customBodyBtnTextSize,customBodyBtnOffsetY));

      mobileAuth.initWindowSytle(new AuthThemeConfig.Builder()
                      .setNavColor(navColor.intValue())
                      .setNavText(navText)
                      .setNavTextColor(navTextColor.intValue())
                      .setNavReturnImgPath(navReturnImgPath)
                      .setAuthNavTransparent(authNavTransparent)
                      .setAuthBGImgPath(authBGImgPath)
                      .setLogoImgPath(logoImgPath)
                      .setLogoWidthDip(logoWidth)
                      .setLogoHeightDip(logoHeight)
                      .setLogoOffsetY(logoOffsetY)
                      .setLogoOffsetY_B(logoOffsetY_B)
                      .setLogoHidden(logoHidden)
                      .setNumberColor(numberColor.intValue())
                      .setNumberSize(numberSize)
                      .setNumFieldOffsetY(numFieldOffsetY)
                      .setNumFieldOffsetY_B(numFieldOffsetY_B)
                      .setLogBtnText(logBtnText)
                      .setLogBtnTextColor(logBtnTextColor.intValue())
                      .setLogBtnImgPath(logBtnImgPath)
                      .setLogBtnOffsetY(logBtnOffsetY)
                      .setLogBtnOffsetY_B(logBtnOffsetY_B)
                      .setSwitchAccHidden(switchAccHidden)
                      .setSwitchAccTextColor(switchAccTextColor.intValue())
                      .setSwitchOffsetY(switchOffsetY)
                      .setSwitchOffsetY_B(switchOffsetY_B)
                      .setClauseOne(clauseOneName,clauseOneUrl)
                      .setClauseTwo(clauseTwoName,clauseTwoUrl)
                      .setClauseColor(clauseColorBase.intValue(),clauseColorAgree.intValue())
                      .setUncheckedImgPath(uncheckedImgPath)
                      .setCheckedImgPath(checkedImgPath)
                      .setPrivacyOffsetY(privacyOffsetY)
                      .setPrivacyOffsetY_B(privacyOffsetY_B)
                      .setSloganTextColor(sloganTextColor.intValue())
                      .setSloganOffsetY(sloganOffsetY)
                      .setSloganOffsetY_B(sloganOffsetY_B)
                      .setSmsNavTransparent(smsNavTransparent)
                      .setSmsNavText(smsNavText)
                      .setSmsLogBtnText(smsLogBtnText)
                      .setSmsLogBtnTextColor(smsLogBtnTextColor.intValue())
                      .setSmsLogBtnImgPath(smsLogBtnImgPath)
                      .setSmsBGImgPath(smsBGImgPath)
                      .setSmsCodeImgPath(smsCodeImgPath)
                      .setSmsCodeBtnTextColor(smsCodeBtnTextColor.intValue())
                      .setSmsSloganTextColor(smsSloganTextColor.intValue())
                      .setPrivacyState(privacyState)
                      .build(),
              cmccDebug,
              useCmccSms,
              customTitleBtnHidden,
              customBodyBtnHidden
      );
      //result.success("sucess");
      return true;
    }
    return false;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if(initPlugin(call,result)){
      return;
    }
//    if(setMobileAuthThemeConfig(call,result)){
//      return;
//    }

    //检验权限
    if( !permissionManager.requestPermission() ){
      result.error("mobileauth","check permission fail",null);
      return;
    }

    if (call.method.equals("networdAndOperator")) {
      mobileAuth.getNetAndOprate(result);
    }else if (call.method.equals("preGetphoneInfo")) {
      mobileAuth.preGetphoneInfo(result);
    }else if (call.method.equals("displayLogin")) {
      setMobileAuthThemeConfig(call,result);
      mobileAuth.displayLogin(result);
    }else if (call.method.equals("implicitLogin")) {
      mobileAuth.implicitLogin(result);
    } else {
      result.notImplemented();
    }
  }
}
