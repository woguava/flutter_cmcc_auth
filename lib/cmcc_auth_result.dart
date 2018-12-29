/**
 * 返回认证结果
 */
class  CMCCMobileAuthResult{
  /**
   * 返回码:
   *  (0 成功 -1 失败)
   */
  int retCode;

  /**
   * 错误原因
   */
  String retMsg;

  /**
   * 具体数据
   */
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