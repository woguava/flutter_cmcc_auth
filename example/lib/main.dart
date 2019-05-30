import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_cmcc_auth/flutter_cmcc_auth.dart';
import 'package:flutter_cmcc_auth/cmcc_auth_options.dart';
import 'package:flutter_cmcc_auth/cmcc_auth_result.dart';
import 'package:flutter_cmcc_auth/cmcc_auth_theme_config.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _restText = '返回结果：';

  String _cmccAppId;
  String _cmccAppKey;
  int _cmccTimeout;

  @override
  void initState() {
    super.initState();
    if(Platform.isIOS){
      _cmccAppId = '300011880083';
      _cmccAppKey = '9DC5CE24E4AAD5603CE62F7D927BBFCC';
    }else if(Platform.isAndroid){
      _cmccAppId = '300011879128';
      _cmccAppKey = '00F1B72734F6D2DC98AFA66A64A1E730';
    }
    _cmccTimeout = 8000;
    CMCCAuthOptions opt = new CMCCAuthOptions(_cmccAppId,_cmccAppKey,expiresln:_cmccTimeout);
    FlutterCmccAuth.setMobileAuthOptions(opt);

    initCMCCSDK();
  }
  

  Future<void> initCMCCSDK() async {
    await FlutterCmccAuth.mobileRegister;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Column(
          children: <Widget>[
            RaisedButton(
                child: Text('获取网络类型和运营商信息'),
                onPressed: () async {
                  CMCCMobileAuthResult result = await FlutterCmccAuth.networdAndOperator;
                  print(result.toString());
                  setState(() {
                    _restText = result.toString();
                  });
                }),
            /*RaisedButton(
                child: Text('设置授权页面主题'),
                onPressed: () async {
                 *//* CMCCAuthThemeConfig themeconfig = new CMCCAuthThemeConfig(
                      navColor : Color.fromARGB(0xff, 0x00, 0x86, 0xd0).value,
                      navText : "统一认证登录",
                      navTextColor : Color.fromARGB(0xff, 0xff, 0xff, 0xff).value,
                      navReturnImgPath : "cmcc_return_bg",
                      authNavTransparent : false,
                      authBGImgPath : "cmcc_root_bg",
                      logoImgPath : 'cmcc_login_logo',
                      logoWidth : 120,
                      logoHeight : 80,
                      logoOffsetY : 100,
                      logoOffsetY_B : 0,
                      logoHidden : false,
                      numberColor :  Color.fromARGB(0xff, 0x33, 0x33, 0x33).value,
                      numberSize : 20,
                      numFieldOffsetY :180,
                      numFieldOffsetY_B : 0,

                      logBtnText : "本机号码一键登录",
                      logBtnTextColor : Color.fromARGB(0xff, 0xff, 0xff, 0xff).value,
                      logBtnImgPath : "cmcc_login_btn_bg",
                      logBtnOffsetY : 254,
                      logBtnOffsetY_B : 0,

                      switchAccHidden:true,
                      switchAccTextColor : Color.fromARGB(0xff, 0x32, 0x9a, 0xf3).value,
                      switchOffsetY : 300,
                      switchOffsetY_B : 0,

                      clauseOneName : '应用自定义服务条款一',
                      clauseOneUrl : 'http://www.baidu.com',
                      clauseTwoName : '应用自定义服务条款二',
                      clauseTwoUrl : 'http://www.sina.com',
                      clauseColorBase : Color.fromARGB(0xff, 0x66, 0x66, 0x66).value,
                      clauseColorAgree : Color.fromARGB(0xff, 0x00, 0x85, 0xd0).value,
                      uncheckedImgPath : "cmcc_uncheck_image",
                      checkedImgPath : "cmcc_check_image",
                      privacyOffsetY : 0,
                      privacyOffsetY_B : 25,
                      privacyState : true,

                      sloganTextColor : Color.fromARGB(0xff, 0x99, 0x99, 0x99).value,
                      sloganOffsetY : 224,
                      sloganOffsetY_B : 0,

                      smsNavTransparent : false,
                      smsNavText : "短信验证登录",
                      smsLogBtnText : "短信验证码登录",
                      smsLogBtnTextColor : Color.fromARGB(0xff, 0xff, 0xff, 0xff).value,
                      smsLogBtnImgPath : "cmcc_login_btn_bg",
                      smsBGImgPath : "cmcc_rootbg",
                      smsCodeImgPath : "cmcc_get_smscode_btn_bg",
                      smsCodeBtnTextColor : Color.fromARGB(0xff, 0xff, 0xff, 0xff).value,
                      smsSloganTextColor : Color.fromARGB(0xff, 0xff, 0xff, 0xff).value,

                      customTitleBtnText : "其它",
                      customTitleBtnTextColor : Color.fromARGB(0xff, 0xff, 0xff, 0xff).value,
                      customTitleBtnTextSize : 15,
                      customTitleBtnHidden : false,
                      customBodyBtnText : "其它方式登录",
                      customBodyBtnTextColor : Color.fromARGB(0xff, 0x33, 0x33, 0x33).value,
                      customBodyBtnTextSize : 15,
                      customBodyBtnHidden : false,
                      customBodyBtnOffsetY: 350,
                      cmccDebug: false,
                      useCmccSms: false);
                  await FlutterCmccAuth.authThemeConfig(themeconfig);*//*
                  setState(() {
                  });
                }),*/
            RaisedButton(
                child: Text('getPhoneInfo(取号)'),
                onPressed: () async {
                  CMCCMobileAuthResult result = await FlutterCmccAuth.preGetphoneInfo;
                  print(result.toString());
                  setState(() {
                    _restText = result.toString();
                  });
                }),
            RaisedButton(
                child: Text('loginAuth(授权登录)'),
                onPressed: () async {
                  CMCCMobileAuthResult result = await FlutterCmccAuth.displayLogin(new CMCCAuthThemeConfig(
                      navColor : Color.fromARGB(0xff, 0x00, 0x86, 0xd0).value,
                      navText : "统一认证登录",
                      navTextColor : Color.fromARGB(0xff, 0xff, 0xff, 0xff).value,
                      navReturnImgPath : "cmcc_return_bg",
                      authNavTransparent : false,
                      authBGImgPath : "cmcc_root_bg",
                      logoImgPath : 'cmcc_login_logo',
                      logoWidth : 120,
                      logoHeight : 80,
                      logoOffsetY : 100,
                      logoOffsetY_B : 0,
                      logoHidden : false,
                      numberColor :  Color.fromARGB(0xff, 0x33, 0x33, 0x33).value,
                      numberSize : 20,
                      numFieldOffsetY :180,
                      numFieldOffsetY_B : 0,

                      logBtnText : "本机号码一键登录",
                      logBtnTextColor : Color.fromARGB(0xff, 0xff, 0xff, 0xff).value,
                      logBtnImgPath : "cmcc_login_btn_bg",
                      logBtnOffsetY : 254,
                      logBtnOffsetY_B : 0,

                      switchAccHidden:true,
                      switchAccTextColor : Color.fromARGB(0xff, 0x32, 0x9a, 0xf3).value,
                      switchOffsetY : 300,
                      switchOffsetY_B : 0,

                      clauseOneName : '应用自定义服务条款一',
                      clauseOneUrl : 'http://www.baidu.com',
                      clauseTwoName : '应用自定义服务条款二',
                      clauseTwoUrl : 'http://www.sina.com',
                      clauseColorBase : Color.fromARGB(0xff, 0x66, 0x66, 0x66).value,
                      clauseColorAgree : Color.fromARGB(0xff, 0x00, 0x85, 0xd0).value,
                      uncheckedImgPath : "cmcc_uncheck_image",
                      checkedImgPath : "cmcc_check_image",
                      privacyOffsetY : 0,
                      privacyOffsetY_B : 25,
                      privacyState : true,

                      sloganTextColor : Color.fromARGB(0xff, 0x99, 0x99, 0x99).value,
                      sloganOffsetY : 224,
                      sloganOffsetY_B : 0,

                      smsNavTransparent : false,
                      smsNavText : "短信验证登录",
                      smsLogBtnText : "短信验证码登录",
                      smsLogBtnTextColor : Color.fromARGB(0xff, 0xff, 0xff, 0xff).value,
                      smsLogBtnImgPath : "cmcc_login_btn_bg",
                      smsBGImgPath : "cmcc_root_bg",
                      smsCodeImgPath : "cmcc_get_smscode_btn_bg",
                      smsCodeBtnTextColor : Color.fromARGB(0xff, 0xff, 0xff, 0xff).value,
                      smsSloganTextColor : Color.fromARGB(0xff, 0xff, 0xff, 0xff).value,

                      customTitleBtnText : "其它",
                      customTitleBtnTextColor : Color.fromARGB(0xff, 0xff, 0xff, 0xff).value,
                      customTitleBtnTextSize : 15,
                      customTitleBtnHidden : false,
                      customBodyBtnText : "其它方式登录",
                      customBodyBtnTextColor : Color.fromARGB(0xff, 0x33, 0x33, 0x33).value,
                      customBodyBtnTextSize : 15,
                      customBodyBtnHidden : false,
                      customBodyBtnOffsetY: 350,
                      cmccDebug: false,
                      useCmccSms: false)
                    );
                  print(result.toString());
                  setState(() {
                    _restText = result.toString();
                  });
                }),
            RaisedButton(
                child: Text('mobileAuth(号码校验)'),
                onPressed: () async {
                  CMCCMobileAuthResult result = await FlutterCmccAuth.implicitLogin;
                  print(result.toString());
                  setState(() {
                    _restText = result.toString();
                  });
                }),
            Text(_restText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
