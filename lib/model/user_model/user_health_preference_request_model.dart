class UserHealthPreferenceRequest {
  String? activityLevel;
  String? sportDifficulty;
  bool? vegan;
  bool? vegetarian;
  bool? halal;

  UserHealthPreferenceRequest(
      {this.activityLevel,
      this.sportDifficulty,
      this.vegan,
      this.vegetarian,
      this.halal});

  UserHealthPreferenceRequest.fromJson(Map<String, dynamic> json) {
    activityLevel = json['activity_level'];
    sportDifficulty = json['sport_difficulty'];
    vegan = json['vegan'];
    vegetarian = json['vegetarian'];
    halal = json['halal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_level'] = this.activityLevel;
    data['sport_difficulty'] = this.sportDifficulty;
    data['vegan'] = this.vegan;
    data['vegetarian'] = this.vegetarian;
    data['halal'] = this.halal;
    return data;
  }
}
