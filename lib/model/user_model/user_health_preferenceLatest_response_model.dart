class UserHealthPreferenceLatestResponse {
  UserHealthPreferenceLatestResponse({
    this.statusCode,
    this.message,
    this.errorCode,
    this.data,
  });
  int? statusCode;
  String? message;
  String? errorCode;
  DataUserHealthPreferenceLatestResponse? data;

  UserHealthPreferenceLatestResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];

    errorCode = json['errorCode'] != null ? json['errorCode'] : '';

    data = json['data'] != null
        ? DataUserHealthPreferenceLatestResponse.fromJson(json['data'])
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

class DataUserHealthPreferenceLatestResponse {
  String? activityLevel;
  String? sportDifficulty;
  bool? vegan;
  bool? vegetarian;
  bool? halal;
  String? date;

  DataUserHealthPreferenceLatestResponse(
      {this.activityLevel,
      this.sportDifficulty,
      this.vegan,
      this.vegetarian,
      this.halal,
      this.date});

  DataUserHealthPreferenceLatestResponse.fromJson(Map<String, dynamic> json) {
    activityLevel = json['activity_level'];
    sportDifficulty = json['sport_difficulty'];
    vegan = json['vegan'];
    vegetarian = json['vegetarian'];
    halal = json['halal'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_level'] = this.activityLevel;
    data['sport_difficulty'] = this.sportDifficulty;
    data['vegan'] = this.vegan;
    data['vegetarian'] = this.vegetarian;
    data['halal'] = this.halal;
    data['date'] = this.date;
    return data;
  }
}
