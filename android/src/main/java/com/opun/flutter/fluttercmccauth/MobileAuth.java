package com.opun.flutter.fluttercmccauth;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.widget.Button;

import com.cmic.sso.sdk.AuthRegisterViewConfig;
import com.cmic.sso.sdk.AuthThemeConfig;
import com.cmic.sso.sdk.auth.AuthnHelper;
import com.cmic.sso.sdk.auth.TokenListener;
import com.cmic.sso.sdk.utils.rglistener.CustomInterface;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class MobileAuth {
    protected String LOG_TAG = "MobileAuth";

    private final Activity g_activity;
    private MethodChannel.Result g_callback;
    private AuthnHelper mAuthnHelper;

    public String mResultString;

    private String[] operatorArray = {"未知","移动","联通","电信"};
    private String[] networkArray = {"未知","数据流量","纯WiFi","流量+WiFi"};

    private static final int CMCC_SDK_REQUEST_GET_PHONE_INFO_CODE = 11001;
    private static final int CMCC_SDK_REQUEST_LOGIN_AUTH_CODE = 11002;

    private Button mTitleBtn,mBtn;

    public MobileAuth(Activity activity){
        this.g_activity = activity;
        mAuthnHelper = AuthnHelper.getInstance(g_activity.getApplicationContext());
    }

    public void initDynamicButton(MobileCustomButton titleBtn,MobileCustomButton bodyBtn){
        mTitleBtn = titleBtn.getCustomButton();
        mBtn = bodyBtn.getCustomButton();
    }

    public void initSDK(AuthThemeConfig themeConfig,boolean cmccDebug,boolean useCmccSms,boolean titleBtnHidden,boolean bodyBtnHidden) {

        AuthnHelper.setDebugMode(cmccDebug);
        mAuthnHelper.SMSAuthOn(useCmccSms); //允许使用短信验证码
        mAuthnHelper.setAuthThemeConfig(themeConfig);

        if(!titleBtnHidden){
            mAuthnHelper.addAuthRegistViewConfig("title_button_umcskd_authority_finish",new AuthRegisterViewConfig.Builder()
                    .setView(mTitleBtn)
                    .setRootViewId(AuthRegisterViewConfig.RootViewId.ROOT_VIEW_ID_TITLE_BAR)
                    .setCustomInterface(new CustomInterface() {
                        @Override
                        public void onClick(Context context) {
                            //Toast.makeText(context,"动态注册的其他按钮",Toast.LENGTH_SHORT).show();
                            Map<String, String> resultMap = new HashMap<String,String>();
                            resultMap.put("resultCode","000000");
                            resultMap.put("btnType",""+MobileCustomButton.TITLE_BTN);
                            g_callback.success(resultMap);
                        }
                    })
                    .build()
            );
        }
        if(!bodyBtnHidden){
            mAuthnHelper.addAuthRegistViewConfig("other_button_umcskd_authority_finish",new AuthRegisterViewConfig.Builder()
                    .setView(mBtn)
                    .setRootViewId(AuthRegisterViewConfig.RootViewId.ROOT_VIEW_ID_BODY)
                    .setCustomInterface(new CustomInterface() {
                        @Override
                        public void onClick(Context context) {
                            //Toast.makeText(context,"动态注册的其他登录按钮",Toast.LENGTH_SHORT).show();
                            Map<String, String> resultMap = new HashMap<String,String>();
                            resultMap.put("resultCode","000000");
                            resultMap.put("btnType",""+MobileCustomButton.BODY_BTN);
                            g_callback.success(resultMap);
                        }
                    })
                    .build()
            );
        }
    }

    /**
     * 需要权限：READ_PHONE_STATE， ACCESS_NETWORK_STATE
     * operatortype获取网络运营商: 0.未知 1.移动流量 2.联通流量网络 3.电信流量网络
     * networktype 网络状态：0未知；1流量 2 wifi；3 数据流量+wifi
     */
    public void getNetAndOprate(final MethodChannel.Result callback){
        JSONObject jsonObject = mAuthnHelper.getNetworkType(g_activity);
        Log.d(LOG_TAG,jsonObject.toString());
        try {
            if(null == jsonObject){
                callback.error("mobile_auth","getNetworkType error!",null);
            }else{
                Map<String, String> resultMap = new HashMap<String,String>();
                int operator = 0;
                if(null != jsonObject.getString("operatorType")){
                    operator = Integer.parseInt(jsonObject.getString("operatorType"));
                }
                resultMap.put("operatorType",""+operator);
                resultMap.put("operatorName",operatorArray[operator]);
                int net = 0;
                if(null != jsonObject.getString("networkType")){
                    net = Integer.parseInt(jsonObject.getString("networkType"));
                }
                resultMap.put("networkType",""+net);
                resultMap.put("networkName",networkArray[net]);

                callback.success(resultMap);
            }
        } catch (JSONException e) {
            e.printStackTrace();
            callback.error("mobile_auth_netandoper",e.getMessage(),null);
        }
    }

    public void preGetphoneInfo(String appId,String appKey,long expiresIn,final MethodChannel.Result callback){
        TokenListener tokenListener = new TokenListener(){
            @Override
            public void onGetTokenComplete(int SDKRequestCode, JSONObject jObj) {
                if (jObj != null) {
                    try {
                        //时间
                        Log.d(LOG_TAG,"SDKRequestCode: " + SDKRequestCode);//调用方式不传SDKRequestCode时，该值默认为：-1
                        Log.d(LOG_TAG,"Result JSONObject: " + jObj.toString());
                        if(SDKRequestCode == CMCC_SDK_REQUEST_GET_PHONE_INFO_CODE){
                            Map<String, String> resultMap = new HashMap<String,String>();
                            resultMap.put("resultCode",""+jObj.getInt("resultCode"));
                            resultMap.put("desc",""+jObj.getBoolean("desc"));
                            callback.success(resultMap);
                        }
                    } catch (JSONException e) {
                        e.printStackTrace();
                        callback.error("mobile_auth_getphone",e.getMessage(),null);
                    }
                }

            }
        };
        mAuthnHelper.getPhoneInfo(appId, appKey, expiresIn, tokenListener, CMCC_SDK_REQUEST_GET_PHONE_INFO_CODE);
    }

    public void displayLogin(String appId,String appKey,final MethodChannel.Result callback){
        g_callback = callback;
        TokenListener tokenListener = new TokenListener(){
            @Override
            public void onGetTokenComplete(int SDKRequestCode, JSONObject jObj) {
                if (jObj != null) {
                    try {
                        //时间
                        Log.d(LOG_TAG,"SDKRequestCode: " + SDKRequestCode);//调用方式不传SDKRequestCode时，该值默认为：-1
                        Log.d(LOG_TAG,"Result JSONObject: " + jObj.toString());
                        if(SDKRequestCode == CMCC_SDK_REQUEST_LOGIN_AUTH_CODE){
                            Map<String, String> resultMap = new HashMap<String,String>();
                            int retCode = jObj.getInt("resultCode");
                            resultMap.put("resultCode",""+jObj.getString("resultCode"));
                            resultMap.put("authType",""+jObj.getString("authType"));
                            resultMap.put("authTypeDes",""+jObj.getString("authTypeDes"));
                            if(retCode == 103000) {
                                //成功时返回：：临时凭证，token有效期2min，一次有效；
                                resultMap.put("token", "" + jObj.getString("token"));
                                //成功时返回：用户身份唯一标识
                                resultMap.put("openId", "" + jObj.getString("openId"));
                            }else{
                                //失败时返回
                                resultMap.put("resultDesc",""+jObj.getString("resultDesc"));
                            }
                            callback.success(resultMap);
                        }
                    } catch (JSONException e) {
                        e.printStackTrace();
                        callback.error("mobile_auth_loginAuth",e.getMessage(),null);
                    }
                }

            }
        };
        mAuthnHelper.loginAuth(appId, appKey, tokenListener, CMCC_SDK_REQUEST_LOGIN_AUTH_CODE);
    }
}
