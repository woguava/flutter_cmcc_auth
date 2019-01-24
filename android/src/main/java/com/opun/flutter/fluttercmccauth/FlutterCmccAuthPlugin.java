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
    if (call.method.equals("mobileAuthThemeConfig")) {
      int navColor = -1;
      if(null != call.argument("navColor")){
        navColor = call.argument("navColor");
      }
      String navText = call.argument("navText");
      int navTextColor = -1;
      if(null != call.argument("navTextColor")){
        navTextColor = call.argument("navTextColor");
      }
      String navReturnImgPath = call.argument("navReturnImgPath");
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
      boolean logoHidden = false;
      if(null != call.argument("logoHidden")) {
        logoHidden = call.argument("logoHidden");
      }
      int numberColor = -1;
      if(null != call.argument("numberColor")) {
        numberColor = call.argument("numberColor");
      }
      boolean switchAccHidden = false;
      if(null != call.argument("switchAccHidden")) {
        switchAccHidden = call.argument("switchAccHidden");
      }
      int switchAccTextColor = -1;
      if(null != call.argument("switchAccTextColor")) {
        switchAccTextColor = call.argument("switchAccTextColor");
      }
      int switchAccOffsetY = 300;
      if(null != call.argument("switchAccOffsetY")){
        switchAccOffsetY = call.argument("switchAccOffsetY");
      }
      int numFieldOffsetY = 184;
      if(null != call.argument("numFieldOffsetY")){
        numFieldOffsetY = call.argument("numFieldOffsetY");
      }
      String logBtnText = call.argument("logBtnText");
      int logBtnOffsetY = 254;
      if(null != call.argument("logBtnOffsetY")) {
        logBtnOffsetY = call.argument("logBtnOffsetY");
      }
      int logBtnTextColor = -1;
      if(null != call.argument("logBtnTextColor")) {
        logBtnTextColor = call.argument("logBtnTextColor");
      }
      String logBtnBackgroundPath = call.argument("logBtnBackgroundPath");
      String uncheckedImgPath = call.argument("uncheckedImgPath");
      String checkedImgPath = call.argument("checkedImgPath");
      int privacyOffsetY = 30;
      if(null != call.argument("privacyOffsetY")) {
        privacyOffsetY = call.argument("privacyOffsetY");
      }
      String clauseName = call.argument("clauseName");
      String clauseUrl = call.argument("clauseUrl");
      int clauseBaseColor = -10066330;
      if(null != call.argument("clauseBaseColor")) {
        clauseBaseColor = call.argument("clauseBaseColor");
      }
      int clauseColor = -16007674;
      if (null != call.argument("clauseColor")) {
        clauseColor = call.argument("clauseColor");
      }
      String clauseNameTwo = call.argument("clauseNameTwo");
      String clauseUrlTwo = call.argument("clauseUrlTwo");
      int sloganOffsetY = 224;
      if (null != call.argument("sloganOffsetY")) {
        sloganOffsetY = call.argument("sloganOffsetY");
      }
      int sloganTextColor = -16007674;
      if(null != call.argument("sloganTextColor")) {
        sloganTextColor = call.argument("sloganTextColor");
      }
      String smsNavText = call.argument("smsNavText");
      String smsLogBtnText = call.argument("smsLogBtnText");
      int smsLogBtnTextColor = -1;
      if(null != call.argument("smsLogBtnTextColor")) {
        smsLogBtnTextColor = call.argument("smsLogBtnTextColor");
      }
      String smsLogBtnImgPath = call.argument("smsLogBtnImgPath");

      String customTitleBtnText = call.argument("customTitleBtnText");
      int customTitleBtnTextColor = -1;
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
      int customBodyBtnTextColor = -1;
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
              new MobileCustomButton(registrar.activeContext(),1,customTitleBtnText,customTitleBtnTextColor,customTitleBtnTextSize,0),
              new MobileCustomButton(registrar.activeContext(),2,customBodyBtnText,customBodyBtnTextColor,customBodyBtnTextSize,customBodyBtnOffsetY));

      mobileAuth.initWindowSytle(new AuthThemeConfig.Builder()
                      .setNavColor(navColor)
                      .setNavText(navText)
                      .setNavTextColor(navTextColor)
                      .setNavReturnImgPath(navReturnImgPath)
                      .setLogoImgPath(logoImgPath)
                      .setLogoWidthDip(logoWidth)
                      .setLogoHeightDip(logoHeight)
                      .setLogoOffsetY(logoOffsetY)
                      .setLogoHidden(logoHidden)
                      .setNumberColor(numberColor)
                      .setNumFieldOffsetY(numFieldOffsetY)
                      .setSwitchAccTextColor(switchAccTextColor)
                      .setSwitchAccHidden(switchAccHidden)
                      .setSwitchOffsetY(switchAccOffsetY)
                      .setLogBtnText(logBtnText)
                      .setLogBtnTextColor(logBtnTextColor)
                      .setLogBtnImgPath(logBtnBackgroundPath)
                      .setLogBtnOffsetY(logBtnOffsetY)
                      .setClauseOne(clauseName,clauseUrl)
                      .setClauseTwo(clauseNameTwo,clauseUrlTwo)
                      .setClauseColor(clauseBaseColor,clauseColor)
                      .setUncheckedImgPath(uncheckedImgPath)
                      .setCheckedImgPath(checkedImgPath)
                      .setSloganTextColor(sloganTextColor)
                      .setSloganOffsetY(sloganOffsetY)
                      .setPrivacyOffsetY(privacyOffsetY)
                      .setSmsLogBtnText(smsLogBtnText)
                      .setSmsLogBtnImgPath(smsLogBtnImgPath)
                      .setSmsLogBtnTextColor(smsLogBtnTextColor)
                      .setSmsNavText(smsNavText)
                      .build(),
              cmccDebug,
              useCmccSms,
              customTitleBtnHidden,
              customBodyBtnHidden
      );
      result.success("sucess");
      return true;
    }
    return false;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if(initPlugin(call,result)){
      return;
    }
    if(setMobileAuthThemeConfig(call,result)){
      return;
    }

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
      mobileAuth.displayLogin(result);
    }else if (call.method.equals("implicitLogin")) {
        mobileAuth.implicitLogin(result);
    } else {
      result.notImplemented();
    }
  }
}
