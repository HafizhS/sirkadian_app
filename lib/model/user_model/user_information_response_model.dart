class UserInformationResponse {
  UserInformationResponse({
    this.statusCode,
    this.message,
    this.errorCode,
    this.data,
  });
  int? statusCode;
  String? message;
  String? errorCode;
  DataUserInformationResponse? data;

  UserInformationResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];

    errorCode = json['errorCode'] != null ? json['errorCode'] : '';

    data = json['data'] != null
        ? DataUserInformationResponse.fromJson(json['data'])
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

class DataUserInformationResponse {
  String? dob;
  String? gender;
  String? lang;

  DataUserInformationResponse({this.dob, this.gender, this.lang});

  DataUserInformationResponse.fromJson(Map<String, dynamic> json) {
    dob = json['dob'];
    gender = json['gender'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['lang'] = this.lang;
    return data;
  }
}
