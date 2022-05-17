class ActivationResponse {
  ActivationResponse({
    this.statusCode,
    this.message,
    this.errorCode,
    this.data,
  });
  int? statusCode;
  String? message;
  String? errorCode;
  DataActivationResponse? data;

  ActivationResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorCode = json['errorCode'] != null ? json['errorCode'] : '';
    data = json['data'] != null
        ? DataActivationResponse.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['message'] = message;
    _data['errorCode'] = errorCode;
    if (this.data != null) {
      _data['data'] = data!.toJson();
    }
    return _data;
  }
}

class DataActivationResponse {
  int? id;
  String? accessToken;
  String? refreshToken;
  String? tokenType;

  DataActivationResponse({this.accessToken, this.refreshToken, this.tokenType});

  DataActivationResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accesToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}
