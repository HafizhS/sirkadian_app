class ActivationRequest {
  String? email;
  int? code;

  ActivationRequest({this.email, this.code});

  ActivationRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['code'] = this.code;
    return data;
  }
}
