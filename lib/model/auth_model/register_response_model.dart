class RegisterResponse {
  RegisterResponse({
    required this.statusCode,
    required this.message,
    this.errorCode,
    required this.data,
  });
  late final int statusCode;
  late final String message;
  late final Null errorCode;
  late final DataRegisterResponse data;

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorCode = null;
    data = DataRegisterResponse.fromJson(json['data']);
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
