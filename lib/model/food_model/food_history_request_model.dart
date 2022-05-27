class FoodHistoryRequest {
  List<Foods>? foods;
  String? foodTime;
  String? foodDate;

  FoodHistoryRequest({this.foods, this.foodTime, this.foodDate});

  FoodHistoryRequest.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = [];
      json['foods'].forEach((v) {
        foods!.add(new Foods.fromJson(v));
      });
    }
    foodTime = json['foodTime'];
    foodDate = json['foodDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foods != null) {
      data['foods'] = this.foods!.map((v) => v.toJson()).toList();
    }
    data['foodTime'] = this.foodTime;
    data['foodDate'] = this.foodDate;
    return data;
  }
}

class Foods {
  String? foodId;
  int? portion;

  Foods({this.foodId, this.portion});

  Foods.fromJson(Map<String, dynamic> json) {
    foodId = json['foodId'];
    portion = json['portion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foodId'] = this.foodId;
    data['portion'] = this.portion;
    return data;
  }
}
