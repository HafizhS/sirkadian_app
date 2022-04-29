class DataLoginResponse {
  int? id;
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  // String? errorCode;

  // LoginResponse({
  //   required this.id,
  //   required this.accessToken,
  //   required this.refreshToken,
  //   required this.tokenType,
  //   // required this.errorCode
  // });

  DataLoginResponse({
    this.id,
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    // required this.errorCode
  });

  DataLoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    tokenType = json['tokenType'];
    // errorCode = json['errorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['tokenType'] = this.tokenType;
    // data['errorCode'] = this.errorCode;
    return data;
  }
}

class LoginResponse {
  LoginResponse({
    required this.statusCode,
    required this.message,
    this.errorCode,
    required this.data,
  });
  late final int statusCode;
  late final String message;
  late final Null errorCode;
  late final DataLoginResponse data;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorCode = null;
    data = DataLoginResponse.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['message'] = message;
    _data['errorCode'] = errorCode;
    _data['data'] = data.toJson();
    return _data;
  }
}
