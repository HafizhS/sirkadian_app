import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NecessityResponse {
  int? statusCode;
  String? message;
  Null errorCode;
  DataNecessityResponse? data;

  NecessityResponse({this.statusCode, this.message, this.errorCode, this.data});

  NecessityResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorCode = json['errorCode'];
    data = json['data'] != null
        ? new DataNecessityResponse.fromJson(json['data'])
        : null;
    ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['errorCode'] = this.errorCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataNecessityResponse {
  int? water;
  Energy? energy;
  Macro? macro;
  Micro? micro;

  DataNecessityResponse({
    this.water,
    this.energy,
  });

  DataNecessityResponse.fromJson(Map<String, dynamic> json) {
    water = json['water'];
    energy =
        json['energy'] != null ? new Energy.fromJson(json['energy']) : null;
    macro = json['macro'] != null ? new Macro.fromJson(json['macro']) : null;
    micro = json['micro'] != null ? new Micro.fromJson(json['micro']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['water'] = this.water;
    if (this.energy != null) {
      data['energy'] = this.energy!.toJson();
    }
    if (this.macro != null) {
      data['macro'] = this.macro!.toJson();
    }
    if (this.micro != null) {
      data['micro'] = this.micro!.toJson();
    }

    return data;
  }
}

class Macro {
  Breakfast? breakfast;
  Lunch? lunch;
  Dinner? dinner;

  Macro({this.breakfast, this.lunch, this.dinner});

  Macro.fromJson(Map<String, dynamic> json) {
    breakfast = json['breakfast'] != null
        ? new Breakfast.fromJson(json['breakfast'])
        : null;
    lunch = json['lunch'] != null ? new Lunch.fromJson(json['lunch']) : null;
    dinner =
        json['dinner'] != null ? new Dinner.fromJson(json['dinner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.breakfast != null) {
      data['breakfast'] = this.breakfast!.toJson();
    }
    if (this.lunch != null) {
      data['lunch'] = this.lunch!.toJson();
    }
    if (this.dinner != null) {
      data['dinner'] = this.dinner!.toJson();
    }

    return data;
  }
}

class Micro {
  double? calcium;
  double? iron;
  double? phosphor;
  double? potassium;
  double? sodium;
  double? zinc;
  double? copper;
  double? vitaminC;
  double? vitaminB1;
  double? vitaminB2;
  double? vitaminB3;
  double? retinol;

  Micro({
    this.calcium,
    this.iron,
    this.phosphor,
    this.potassium,
    this.sodium,
    this.zinc,
    this.copper,
    this.vitaminC,
    this.vitaminB1,
    this.vitaminB2,
    this.vitaminB3,
    this.retinol,
  });

  Micro.fromJson(Map<String, dynamic> json) {
    calcium = json['calcium'];
    iron = json['iron'];
    phosphor = json['phosphor'];
    potassium = json['potassium'];
    sodium = json['sodium'];
    zinc = json['zinc'];
    copper = json['copper'];
    vitaminC = json['vitaminC'];
    vitaminB1 = json['vitaminB1'];
    vitaminB2 = json['vitaminB2'];
    vitaminB3 = json['vitaminB3'];
    retinol = json['retinol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calcium'] = this.calcium;
    data['iron'] = this.iron;
    data['phosphor'] = this.phosphor;
    data['potassium'] = this.potassium;
    data['sodium'] = this.sodium;
    data['zinc'] = this.zinc;
    data['copper'] = this.copper;
    data['vitaminC'] = this.vitaminC;
    data['vitaminB1'] = this.vitaminB1;
    data['vitaminB2'] = this.vitaminB2;
    data['vitaminB3'] = this.vitaminB3;
    data['retinol'] = this.retinol;

    return data;
  }
}

class Breakfast {
  double? protein;
  double? fat;
  double? carbohydrate;
  double? fiber;

  Breakfast({this.protein, this.carbohydrate, this.fat, this.fiber});
  Breakfast.fromJson(Map<String, dynamic> json) {
    protein = json['protein'];
    fat = json['fat'];
    carbohydrate = json['carbohydrate'];
    fiber = json['fiber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['protein'] = this.protein;
    data['fat'] = this.fat;
    data['carbohydrate'] = this.carbohydrate;
    data['fiber'] = this.fiber;

    return data;
  }
}

class Lunch {
  double? protein;
  double? fat;
  double? carbohydrate;
  double? fiber;

  Lunch({this.protein, this.carbohydrate, this.fat, this.fiber});
  Lunch.fromJson(Map<String, dynamic> json) {
    protein = json['protein'];
    fat = json['fat'];
    carbohydrate = json['carbohydrate'];
    fiber = json['fiber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['protein'] = this.protein;
    data['fat'] = this.fat;
    data['carbohydrate'] = this.carbohydrate;
    data['fiber'] = this.fiber;

    return data;
  }
}

class Dinner {
  double? protein;
  double? fat;
  double? carbohydrate;
  double? fiber;

  Dinner({this.protein, this.carbohydrate, this.fat, this.fiber});
  Dinner.fromJson(Map<String, dynamic> json) {
    protein = json['protein'];
    fat = json['fat'];
    carbohydrate = json['carbohydrate'];
    fiber = json['fiber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['protein'] = this.protein;
    data['fat'] = this.fat;
    data['carbohydrate'] = this.carbohydrate;
    data['fiber'] = this.fiber;

    return data;
  }
}

class Energy {
  double? breakfast;
  double? lunch;
  double? dinner;

  Energy({this.breakfast, this.lunch, this.dinner});

  Energy.fromJson(Map<String, dynamic> json) {
    breakfast = json['breakfast'];
    lunch = json['lunch'];
    dinner = json['dinner'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['breakfast'] = this.breakfast;
    data['lunch'] = this.lunch;
    data['dinner'] = this.dinner;

    return data;
  }
}

class NecessityDisplayModel {
  final String title;
  final Color gaugeColor;
  final double value;

  NecessityDisplayModel(this.title, this.gaugeColor, this.value);
}
