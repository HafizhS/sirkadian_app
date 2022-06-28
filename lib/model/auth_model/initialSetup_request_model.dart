class InitialSetupRequest {
  String? dob;
  String? gender;
  String? lang;
  String? displayName;
  int? height;
  int? weight;
  String? activityLevel;
  String? sportDifficulty;
  bool? vegan;
  bool? vegetarian;
  bool? halal;

  InitialSetupRequest(
      {this.dob,
      this.gender,
      this.lang,
      this.displayName,
      this.height,
      this.weight,
      this.activityLevel,
      this.sportDifficulty,
      this.vegan,
      this.vegetarian,
      this.halal});

  InitialSetupRequest.fromJson(Map<String, dynamic> json) {
    dob = json['dob'];
    gender = json['gender'];
    lang = json['lang'];
    displayName = json['display_name'];
    height = json['height'];
    weight = json['weight'];
    activityLevel = json['activity_level'];
    sportDifficulty = json['sport_difficulty'];
    vegan = json['vegan'];
    vegetarian = json['vegetarian'];
    halal = json['halal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['lang'] = this.lang;
    data['display_name'] = this.displayName;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['activity_level'] = this.activityLevel;
    data['sport_difficulty'] = this.sportDifficulty;
    data['vegan'] = this.vegan;
    data['vegetarian'] = this.vegetarian;
    data['halal'] = this.halal;
    return data;
  }
}
