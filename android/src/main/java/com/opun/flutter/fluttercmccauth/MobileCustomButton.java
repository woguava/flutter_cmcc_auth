package com.opun.flutter.fluttercmccauth;

import android.content.Context;
import android.graphics.Color;
import android.util.TypedValue;
import android.widget.Button;
import android.widget.RelativeLayout;


public class MobileCustomButton{
    private  Context context;
    private  int btnType;
    private String btnText;
    private int  btnTextColor;
    private int  btnTextSize;
    private int  btnOffsetY;

    public static final int TITLE_BTN = 1;
    public static final int BODY_BTN = 2;

    public  MobileCustomButton(Context context,int btnType,String btnText,int  btnTextColor,int  btnTextSize,int btnOffsetY){
       this.context = context;
       this.btnType = btnType;
       this.btnText = btnText;
       this.btnTextColor = btnTextColor;
       this.btnTextSize = btnTextSize;
       this.btnOffsetY =  btnOffsetY;
    }

    public Button getCustomButton(){
        Button oneButton = new Button(context);
        oneButton.setText(btnText);
        oneButton.setTextColor(btnTextColor);
        oneButton.setTextSize(TypedValue.COMPLEX_UNIT_SP, btnTextSize);
        oneButton.setBackgroundColor(Color.TRANSPARENT);
        RelativeLayout.LayoutParams mLayoutParams = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT,RelativeLayout.LayoutParams.WRAP_CONTENT);

        if(btnType == TITLE_BTN) {
            mLayoutParams.addRule(RelativeLayout.ALIGN_PARENT_RIGHT, RelativeLayout.TRUE);
            mLayoutParams.addRule(RelativeLayout.CENTER_VERTICAL);
            mLayoutParams.setMargins(0, 0, MobileParmUtil.dip2px(context, 10), 0);
        }else if(btnType == BODY_BTN){
            mLayoutParams.addRule(RelativeLayout.CENTER_HORIZONTAL,RelativeLayout.TRUE);
            mLayoutParams.setMargins(0, MobileParmUtil.dip2px(context,btnOffsetY),0,0);
        }
        oneButton.setLayoutParams(mLayoutParams);
        return oneButton;
    }

}
