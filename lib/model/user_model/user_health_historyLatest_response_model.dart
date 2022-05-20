class UserHealthHistoryLatestResponse {
  UserHealthHistoryLatestResponse({
    this.statusCode,
    this.message,
    this.errorCode,
    this.data,
  });
  int? statusCode;
  String? message;
  String? errorCode;
  DataUserHealthHistoryLatestResponse? data;

  UserHealthHistoryLatestResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];

    errorCode = json['errorCode'] != null ? json['errorCode'] : '';

    data = json['data'] != null
        ? DataUserHealthHistoryLatestResponse.fromJson(json['data'])
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

class DataUserHealthHistoryLatestResponse {
  double? height;
  double? weight;
  String? date;

  DataUserHealthHistoryLatestResponse({this.height, this.weight, this.date});

  DataUserHealthHistoryLatestResponse.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    weight = json['weight'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['date'] = this.date;
    return data;
  }
}
