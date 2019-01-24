import 'dart:async';

import 'package:flutter/services.dart';

import 'package:flutter_cmcc_auth/cmcc_auth_options.dart';
import 'package:flutter_cmcc_auth/cmcc_auth_result.dart';
import 'package:flutter_cmcc_auth/cmcc_auth_theme_config.dart';

class FlutterCmccAuth {
  static const MethodChannel _channel =
      const MethodChannel('flutter_cmcc_auth');

  static CMCCAuthOptions _options;
  static bool  _optionsInit = false;
  static bool  _registerInit = false;

  static const List<String> operatorArray = ['未知','移动','联通','电信'];
  static const List<String> networkArray = ["未知","数据流量","纯WiFi","流量+WiFi"];

  static void setMobileAuthOptions(final CMCCAuthOptions opt){
    _options = opt;
    _optionsInit = true;
  }

  ///注册服务
  static Future<void> get mobileRegister async {
    if(!_optionsInit){
      print("[setMobileAuthOptions] 未初始化！");
      return;
    }
    print('mobile register begin...');
    await _channel.invokeMethod('mobileRegister',<String, dynamic>{
        'appId': _options.appid,
        'appkey': _options.appkey,
        'expiresln':_options.expiresln
      });
    print('mobile register end...');
    _registerInit = true;
  }

  static Future<void> authThemeConfig(CMCCAuthThemeConfig themeconfig) async {
    await _channel.invokeMethod('mobileAuthThemeConfig',themeconfig.toJson());
  }


   /// 需要权限：READ_PHONE_STATE， ACCESS_NETWORK_STATE
   /// operatortype获取网络运营商: 0.未知 1.移动流量 2.联通流量网络 3.电信流量网络
   /// networktype 网络状态：0未知；1流量 2 wifi；3 数据流量+wifi
  static Future<CMCCMobileAuthResult> get networdAndOperator async {
    try{

      var res =  await _channel.invokeMethod('networdAndOperator');

      CMCCMobileAuthResult result = new CMCCMobileAuthResult();

      result.setProcResult(0, "成功",data:res);
      return result;
    } on PlatformException catch (e) {
      print(e);
      CMCCMobileAuthResult result = new CMCCMobileAuthResult();
      result.setProcResult(-1,e.toString());
      return result;
    }
  }

  ///预取号
  static Future<CMCCMobileAuthResult> get preGetphoneInfo async {
    if(!_registerInit){
      final CMCCMobileAuthResult result = new CMCCMobileAuthResult();
      result.setProcResult(-1, "未初始化[ mobileRegister ]");
      return result;
    }

    try{
      var res =  await _channel.invokeMethod('preGetphoneInfo');

      CMCCMobileAuthResult result = new CMCCMobileAuthResult();
      if( res['resultCode'] == "103000"){
        result.setProcResult(0, "成功",data:res);
      }else{
        result.setProcResult(-1, "失败",data:res);
      }
      return result;
    } on PlatformException catch (e) {
      print(e);
      CMCCMobileAuthResult result = new CMCCMobileAuthResult();
      result.setProcResult(-1,e.toString());
      return result;
    }
  }

  ///显示一键登录
  static Future<CMCCMobileAuthResult> get displayLogin async {
    if(!_registerInit){
      final CMCCMobileAuthResult result = new CMCCMobileAuthResult();
      result.setProcResult(-1, "未初始化[ mobileRegister ]");
      return result;
    }

    try{
      var res =  await _channel.invokeMethod('displayLogin');

      CMCCMobileAuthResult result = new CMCCMobileAuthResult();
      if( res['resultCode'] == "103000"){
        result.setProcResult(0, "成功",data:res);
      }else if(res['resultCode'] == "200020"){
        result.setProcResult(-2, "用户取消登录",data:res);
      } else if(res['resultCode'] == "000000"){
        result.setProcResult(-2, "用户切换登录",data:res);
      }else{
        result.setProcResult(-1, "失败",data:res);
      }
      return result;
    } on PlatformException catch (e) {
      print(e);
      CMCCMobileAuthResult result = new CMCCMobileAuthResult();
      result.setProcResult(-1,e.toString());
      return result;
    }
  }

  ///本机号码验证
  static Future<CMCCMobileAuthResult> get implicitLogin async{
    if(!_registerInit){
      final CMCCMobileAuthResult result = new CMCCMobileAuthResult();
      result.setProcResult(-1, "未初始化[ mobileRegister ]");
      return result;
    }

    try{
      var res =  await _channel.invokeMethod('implicitLogin');

      CMCCMobileAuthResult result = new CMCCMobileAuthResult();
      if( res['resultCode'] == "103000"){
        result.setProcResult(0, "成功",data:res);
      }else{
        result.setProcResult(-1, "失败",data:res);
      }
      return result;
    } on PlatformException catch (e) {
      print(e);
      CMCCMobileAuthResult result = new CMCCMobileAuthResult();
      result.setProcResult(-1,e.toString());
      return result;
    }

  }
}
