class ExerciseAllResponse {
  int? statusCode;
  String? message;
  Null errorCode;
  List<DataExerciseAllResponse>? data;

  ExerciseAllResponse(
      {this.statusCode, this.message, this.errorCode, this.data});

  ExerciseAllResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DataExerciseAllResponse>[];
      json['data'].forEach((v) {
        data!.add(new DataExerciseAllResponse.fromJson(v));
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

class DataExerciseAllResponse {
  String? name;
  String? desc;
  double? mets;
  String? difficulty;
  int? sportId;
  List<Variations>? variations;
  String? imageFilename;

  DataExerciseAllResponse(
      {this.name,
      this.desc,
      this.mets,
      this.difficulty,
      this.sportId,
      this.variations,
      this.imageFilename});

  DataExerciseAllResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desc = json['desc'];
    mets = json['mets'];
    difficulty = json['difficulty'];
    sportId = json['sportId'];
    imageFilename =
        json['image_filename'] != null ? json['image_filename'] : '';
    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(new Variations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['mets'] = this.mets;
    data['difficulty'] = this.difficulty;
    data['sportId'] = this.sportId;
    data['image_filename'] = this.imageFilename;
    if (this.variations != null) {
      data['variations'] = this.variations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variations {
  int? sportId;
  String? name;
  String? desc;
  String? difficulty;
  double? mets;
  int? sportVariationId;
  List<Subvariations>? subvariations;

  Variations(
      {this.sportId,
      this.name,
      this.desc,
      this.difficulty,
      this.mets,
      this.sportVariationId,
      this.subvariations});

  Variations.fromJson(Map<String, dynamic> json) {
    sportId = json['sportId'];
    name = json['name'];
    desc = json['desc'];
    difficulty = json['difficulty'];
    mets = json['mets'];
    sportVariationId = json['sportVariationId'];
    if (json['subvariations'] != null) {
      subvariations = [];
      json['subvariations'].forEach((v) {
        subvariations!.add(new Subvariations.fromJson(v));
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
    if (this.subvariations != null) {
      data['subvariations'] =
          this.subvariations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subvariations {
  int? sportVariationId;
  int? amount;
  int? set;
  int? duration;
  int? sportSubVariationId;

  Subvariations(
      {this.sportVariationId,
      this.amount,
      this.set,
      this.duration,
      this.sportSubVariationId});

  Subvariations.fromJson(Map<String, dynamic> json) {
    sportVariationId = json['sportVariationId'];
    amount = json['amount'];
    set = json['set'];
    duration = json['duration'];
    sportSubVariationId = json['sportSubVariationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sportVariationId'] = this.sportVariationId;
    data['amount'] = this.amount;
    data['set'] = this.set;
    data['duration'] = this.duration;
    data['sportSubVariationId'] = this.sportSubVariationId;
    return data;
  }
}
