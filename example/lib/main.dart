import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_cmcc_auth/flutter_cmcc_auth.dart';
import 'package:flutter_cmcc_auth/cmcc_auth_options.dart';
import 'package:flutter_cmcc_auth/cmcc_auth_result.dart';
import 'package:flutter_cmcc_auth/cmcc_auth_theme_config.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _restText = '返回结果：';

  @override
  void initState() {
    super.initState();
    //initPlatformState();
    CMCCAuthOptions opt = new CMCCAuthOptions('300011879128','00F1B72734F6D2DC98AFA66A64A1E730',expiresln:8000);
    FlutterCmccAuth.setMobileAuthOptions(opt);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterCmccAuth.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
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
            RaisedButton(
                child: Text('设置授权页面主题'),
                onPressed: () async {
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
                      switchAccHidden:true,
                      switchAccTextColor : -1,
                      switchAccOffsetY : 300,
                      numFieldOffsetY : 180,
                      logBtnText : "本机号码一键登录",
                      logBtnOffsetY : 254,
                      logBtnTextColor : -1,
                      logBtnBackgroundPath : "cmcc_login_btn_bg",
                      uncheckedImgPath : "cmcc_uncheck_image",
                      checkedImgPath : "cmcc_check_image",
                      privacyOffsetY : 25,
                      //clauseName,
                      //clauseUrl,
                      clauseBaseColor : -10066330,
                      clauseColor : -16007674,
                      //clauseNameTwo,
                      //clauseUrlTwo,
                      sloganOffsetY : 224,
                      sloganTextColor : -10066330,
                      smsNavText : "短信验证登录",
                      smsLogBtnText : "短信验证码登录",
                      smsLogBtnTextColor : -1,
                      smsLogBtnImgPath : "cmcc_login_btn_bg",
                      customTitleBtnText : "其它",
                      customTitleBtnTextColor : -1,
                      customTitleBtnTextSize : 15,
                      customTitleBtnHidden : true,
                      customBodyBtnText : "其它方式登录",
                      customBodyBtnTextColor : -108766,
                      customBodyBtnTextSize : 15,
                      customBodyBtnHidden : false,
                      customBodyBtnOffsetY: 300,
                      cmccDebug: true,
                      useCmccSms: false);
                  await FlutterCmccAuth.authThemeConfig(themeconfig);
                  setState(() {
                  });
                }),
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
                  CMCCMobileAuthResult result = await FlutterCmccAuth.displayLogin;
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
