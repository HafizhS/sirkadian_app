class RegisterRequest {
  String? username;
  String? password;
  String? email;

  RegisterRequest(
      {required this.username, required this.password, required this.email});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    return data;
  }
}
