class SubscriptionAllResponse {
  int? statusCode;
  String? message;
  Null errorCode;
  List<DataSubscriptionAllResponse>? data;

  SubscriptionAllResponse(
      {this.statusCode, this.message, this.errorCode, this.data});

  SubscriptionAllResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new DataSubscriptionAllResponse.fromJson(v));
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

class DataSubscriptionAllResponse {
  String? subscriptionType;
  int? id;
  List<SubscriptionPackages>? subscriptionPackages;

  DataSubscriptionAllResponse(
      {this.subscriptionType, this.id, this.subscriptionPackages});

  DataSubscriptionAllResponse.fromJson(Map<String, dynamic> json) {
    subscriptionType = json['subscriptionType'];
    id = json['id'];
    if (json['subscriptionPackages'] != null) {
      subscriptionPackages = [];
      json['subscriptionPackages'].forEach((v) {
        subscriptionPackages!.add(new SubscriptionPackages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscriptionType'] = this.subscriptionType;
    data['id'] = this.id;
    data['subscriptionPackages'] =
        this.subscriptionPackages!.map((v) => v.toJson()).toList();
    return data;
  }
}

class SubscriptionPackages {
  String? name;
  String? description;
  double? price;
  int? validityPeriod;
  String? subscriptionTypeName;
  int? id;

  SubscriptionPackages(
      {this.name,
      this.description,
      this.price,
      this.validityPeriod,
      this.subscriptionTypeName,
      this.id});

  SubscriptionPackages.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    price = json['price'];
    validityPeriod = json['validityPeriod'];
    subscriptionTypeName = json['subscription_type_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['validityPeriod'] = this.validityPeriod;
    data['subscription_type_name'] = this.subscriptionTypeName;
    data['id'] = this.id;
    return data;
  }
}
