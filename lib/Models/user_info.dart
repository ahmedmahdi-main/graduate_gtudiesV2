class UserInfo {
  String? accessToken;
  String? tokenType;
  String? uuid;
  int? expiresIn;
  int? code;
  String? otp;

  UserInfo({this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.code,
    this.otp,
    this.uuid});

  fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    uuid = json['uuid'];
    code = json['code'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    data['uuid'] = uuid;
    data['code'] = code;
    data['otp'] = otp;
    return data;
  }
}
