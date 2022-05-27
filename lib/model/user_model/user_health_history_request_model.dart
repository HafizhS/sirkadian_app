class UserHealthHistoryRequest {
  int? height;
  int? weight;

  UserHealthHistoryRequest({this.height, this.weight});

  UserHealthHistoryRequest.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['weight'] = this.weight;
    return data;
  }
}
