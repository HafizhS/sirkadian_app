class RegisterResponse {
  RegisterResponse({
    this.statusCode,
    this.message,
    this.errorCode,
    this.data,
  });
  int? statusCode;
  String? message;
  String? errorCode;
  DataRegisterResponse? data;

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorCode = json['errorCode'] != null ? json['errorCode'] : '';
    data = json['data'] != null
        ? DataRegisterResponse.fromJson(json['data'])
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

class DataRegisterResponse {
  int? id;

  DataRegisterResponse({this.id});

  DataRegisterResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
