//认证参数
class CMCCAuthOptions{
  //appid
  String _appid;

  //appkey
  String _appkey;

  //超时时间
  int _expiresln;

  CMCCAuthOptions(String appid,String appkey,int expiresln){
    this._appid = appid;
    this._appkey = appkey;
    this._expiresln = expiresln;
  }

  int get expiresln => _expiresln;

  String get appkey => _appkey;

  String get appid => _appid;

}