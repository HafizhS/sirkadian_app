class ExerciseHistoryRequest {
  List<Sports>? sports;
  String? sportDate;

  ExerciseHistoryRequest({this.sports, this.sportDate});

  ExerciseHistoryRequest.fromJson(Map<String, dynamic> json) {
    if (json['sports'] != null) {
      sports = <Sports>[];
      json['sports'].forEach((v) {
        sports!.add(new Sports.fromJson(v));
      });
    }
    sportDate = json['sportDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sports != null) {
      data['sports'] = this.sports!.map((v) => v.toJson()).toList();
    }
    data['sportDate'] = this.sportDate;
    return data;
  }
}

class Sports {
  int? sportId;
  int? sportVariationId;
  int? duration;
  int? amount;
  int? set;

  Sports(
      {this.sportId,
      this.sportVariationId,
      this.duration,
      this.amount,
      this.set});

  Sports.fromJson(Map<String, dynamic> json) {
    sportId = json['sportId'];
    sportVariationId = json['sportVariationId'];
    duration = json['duration'];
    amount = json['amount'];
    set = json['set'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sportId'] = this.sportId;
    data['sportVariationId'] = this.sportVariationId;
    data['duration'] = this.duration;
    data['amount'] = this.amount;
    data['set'] = this.set;
    return data;
  }
}
