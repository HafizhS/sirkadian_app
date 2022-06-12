class SubscriptionHistoryUserResponse {
  int? statusCode;
  String? message;
  Null errorCode;
  List<DataSubscriptionHistoryUserResponse>? data;

  SubscriptionHistoryUserResponse(
      {this.statusCode, this.message, this.errorCode, this.data});

  SubscriptionHistoryUserResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new DataSubscriptionHistoryUserResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['errorCode'] = this.errorCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataSubscriptionHistoryUserResponse {
  int? id;
  String? subscriptionPackageName;
  String? subscriptionTypeName;
  String? expirationDate;
  int? isExpired;

  DataSubscriptionHistoryUserResponse(
      {this.id,
      this.subscriptionPackageName,
      this.subscriptionTypeName,
      this.expirationDate,
      this.isExpired});

  DataSubscriptionHistoryUserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subscriptionPackageName = json['subscription_package_name'];
    subscriptionTypeName = json['subscription_type_name'];
    expirationDate = json['expiration_date'];
    isExpired = json['is_expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subscription_package_name'] = this.subscriptionPackageName;
    data['subscription_type_name'] = this.subscriptionTypeName;
    data['expiration_date'] = this.expirationDate;
    data['is_expired'] = this.isExpired;
    return data;
  }
}
