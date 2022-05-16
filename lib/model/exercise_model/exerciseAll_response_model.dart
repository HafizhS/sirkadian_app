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

  DataExerciseAllResponse(
      {this.name,
      this.desc,
      this.mets,
      this.difficulty,
      this.sportId,
      this.variations});

  DataExerciseAllResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desc = json['desc'];
    mets = json['mets'];
    difficulty = json['difficulty'];
    sportId = json['sportId'];
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
  List<String>? subvariations;

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
      subvariations = <String>[];
      json['subvariations'].forEach((v) {
        subvariations!.add(v);
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
      data['subvariations'] = this.subvariations!.map((v) => v).toList();
    }
    return data;
  }
}
