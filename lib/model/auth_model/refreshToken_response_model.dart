class RefreshTokenResponse {
  RefreshTokenResponse({
    this.statusCode,
    this.message,
    this.errorCode,
    this.data,
  });
  late final int? statusCode;
  late final String? message;
  late final Null errorCode;
  late final DataRefreshTokenResponse? data;

  RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorCode = null;
    data = DataRefreshTokenResponse.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['message'] = message;
    _data['errorCode'] = errorCode;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class DataRefreshTokenResponse {
  int? id;
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  DataRefreshTokenResponse({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  });

  DataRefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    accessToken = json["accessToken"];
    refreshToken = json["refreshToken"];
    tokenType = json["tokenType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["accessToken"] = accessToken;
    data["refreshToken"] = refreshToken;
    data["tokenType"] = tokenType;
    return data;
  }
}
