package com.opun.flutter.fluttercmccauth;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageManager;
import android.support.v4.app.ActivityCompat;
import android.widget.Toast;

import io.flutter.plugin.common.PluginRegistry;


public class PermissionManager implements PluginRegistry.RequestPermissionsResultListener{
    private final Activity activity;
    private static final int PERMISSIONS_REQUEST_CODE = 10001;

    private static final String[] permissionArray = new String[]{
            Manifest.permission.INTERNET,
            Manifest.permission.ACCESS_NETWORK_STATE,
            Manifest.permission.ACCESS_WIFI_STATE,
            Manifest.permission.READ_PHONE_STATE,
            Manifest.permission.CHANGE_NETWORK_STATE
    };

    public PermissionManager(final Activity activity){
        this.activity = activity;
    }

    public boolean requestPermission(){
        boolean isAskPermission = false;
        for(int i = 0; i < permissionArray.length; i++){
            if( !isPermissionGranted(permissionArray[i]) ){
                isAskPermission = true;
                break;
            }
        }
        if(isAskPermission){
            askForPermission(permissionArray,PERMISSIONS_REQUEST_CODE);
            return  false;
        }
        return  true;
    }


    public boolean isPermissionGranted(String permissionName) {
        return ActivityCompat.checkSelfPermission(activity, permissionName)
                == PackageManager.PERMISSION_GRANTED;
    }

    public void askForPermission(String[] permissions, int requestCode) {
        ActivityCompat.requestPermissions(activity, permissions, requestCode);
    }

    private static void showToast(Context ctx, String msg) {
        Toast.makeText(ctx, msg, Toast.LENGTH_LONG).show();
    }

    @Override
    public boolean onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        switch (requestCode) {
            case PERMISSIONS_REQUEST_CODE: {
                // 用户取消了权限弹窗
                if (grantResults.length == 0) {
                    showToast(activity, "无法获取应用所需的权限, 请到系统设置开启");
                    return false;
                }

                // 用户拒绝了某些权限
                for (int x : grantResults) {
                    if (x == PackageManager.PERMISSION_DENIED) {
                        showToast(activity, "无法获取应用所需的权限, 请到系统设置开启");
                        return false;
                    }
                }
                // 所需的权限均正常获取
                showToast(activity, "应用所需的权限已经正常获取");
            }
        }

        return true;
    }
}
