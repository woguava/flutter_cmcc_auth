///移动认证返回
class  CMCCMobileAuthResult{
  ///返回码：(0 成功 -1 失败 -2 用户取消)
  int retCode;

  ///错误原因
  String retMsg;

  //具体接口返回数据
  dynamic data;

  void setProcResult(int retCode,String retMsg,{dynamic data}){
    this.retCode = retCode;
    this.retMsg = retMsg;
    this.data = data;
  }

  @override
  String toString(){
    String result = '{retCode:$retCode,retMsg:$retMsg,data:$data}';
    return result;
  }
}