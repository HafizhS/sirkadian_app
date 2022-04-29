class DataWebsocketResponse {
  String? purpose;
  String? code;

  DataWebsocketResponse({this.purpose, this.code});

  DataWebsocketResponse.fromJson(Map<String, dynamic> json) {
    purpose = json['purpose'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['purpose'] = this.purpose;
    data['code'] = this.code;
    return data;
  }
}
