class ExerciseHistoryPostResponse {
  int? statusCode;
  String? message;
  Null errorCode;
  List<ExerciseHistoryPostResponse>? data;

  ExerciseHistoryPostResponse(
      {this.statusCode, this.message, this.errorCode, this.data});

  ExerciseHistoryPostResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <ExerciseHistoryPostResponse>[];
      json['data'].forEach((v) {
        data!.add(new ExerciseHistoryPostResponse.fromJson(v));
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

class ExersiceHistoryPostResponse {
  List<Sports>? sports;
  String? sportDate;
  int? totalDuration;
  int? totalBurnedKcal;

  ExersiceHistoryPostResponse(
      {this.sports, this.sportDate, this.totalDuration, this.totalBurnedKcal});

  ExersiceHistoryPostResponse.fromJson(Map<String, dynamic> json) {
    if (json['sports'] != null) {
      sports = <Sports>[];
      json['sports'].forEach((v) {
        sports!.add(new Sports.fromJson(v));
      });
    }
    sportDate = json['sport_date'];
    totalDuration = json['totalDuration'];
    totalBurnedKcal = json['totalBurnedKcal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sports != null) {
      data['sports'] = this.sports!.map((v) => v.toJson()).toList();
    }
    data['sport_date'] = this.sportDate;
    data['totalDuration'] = this.totalDuration;
    data['totalBurnedKcal'] = this.totalBurnedKcal;
    return data;
  }
}

class Sports {
  Sport? sport;
  int? duration;
  int? amount;
  int? set;
  int? burnedKcal;
  SportVariation? sportVariation;

  Sports(
      {this.sport,
      this.duration,
      this.amount,
      this.set,
      this.burnedKcal,
      this.sportVariation});

  Sports.fromJson(Map<String, dynamic> json) {
    sport = json['sport'] != null ? new Sport.fromJson(json['sport']) : null;
    duration = json['duration'];
    amount = json['amount'];
    set = json['set'];
    burnedKcal = json['burnedKcal'];
    sportVariation = json['sport_variation'] != null
        ? new SportVariation.fromJson(json['sport_variation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sport != null) {
      data['sport'] = this.sport!.toJson();
    }
    data['duration'] = this.duration;
    data['amount'] = this.amount;
    data['set'] = this.set;
    data['burnedKcal'] = this.burnedKcal;
    if (this.sportVariation != null) {
      data['sport_variation'] = this.sportVariation!.toJson();
    }
    return data;
  }
}

class Sport {
  String? name;
  String? desc;
  double? mets;
  String? difficulty;
  int? sportId;
  List<Null>? variations;
  String? imageFilename;

  Sport(
      {this.name,
      this.desc,
      this.mets,
      this.difficulty,
      this.sportId,
      this.variations,
      this.imageFilename});

  Sport.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desc = json['desc'];
    mets = json['mets'];
    difficulty = json['difficulty'];
    sportId = json['sportId'];
    if (json['variations'] != null) {
      variations = <Null>[];
      json['variations'].forEach((v) {
        // variations!.add(new Null.fromJson(v));
      });
    }
    imageFilename = json['imageFilename'] != null ? json['imageFilename'] : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['mets'] = this.mets;
    data['difficulty'] = this.difficulty;
    data['sportId'] = this.sportId;
    if (this.variations != null) {
      // data['variations'] = this.variations!.map((v) => v.toJson()).toList();
    }
    data['imageFilename'] = this.imageFilename;
    return data;
  }
}

class SportVariation {
  int? sportId;
  String? name;
  String? desc;
  String? difficulty;
  double? mets;
  int? sportVariationId;
  String? imageFilename;
  List<Null>? subvariations;

  SportVariation(
      {this.sportId,
      this.name,
      this.desc,
      this.difficulty,
      this.mets,
      this.sportVariationId,
      this.imageFilename,
      this.subvariations});

  SportVariation.fromJson(Map<String, dynamic> json) {
    sportId = json['sportId'];
    name = json['name'];
    desc = json['desc'];
    difficulty = json['difficulty'];
    mets = json['mets'];
    sportVariationId = json['sportVariationId'];
    imageFilename = json['image_filename'];
    if (json['subvariations'] != null) {
      subvariations = <Null>[];
      json['subvariations'].forEach((v) {
        // subvariations!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sportId'] = this.sportId;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['difficulty'] = this.difficulty;
    data['mets'] = this.mets;
    data['sportVariationId'] = this.sportVariationId;
    data['image_filename'] = this.imageFilename;
    if (this.subvariations != null) {
      // data['subvariations'] =
      // this.subvariations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
