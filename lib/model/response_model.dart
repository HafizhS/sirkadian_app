class Response {
  Response({
    required this.code,
    required this.message,
    this.errorCode,
    required this.data,
  });
  late final int code;
  late final String message;
  late final Null errorCode;
  late final dynamic data;

  Response.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    errorCode = null;
    data = data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    _data['error_code'] = errorCode;
    _data['data'] = data.toJson();
    return _data;
  }
}
