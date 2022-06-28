class FoodRecommendationMenuResponse {
  int? statusCode;
  String? message;
  Null errorCode;
  List<DataFoodRecommendationMenuResponse>? data;

  FoodRecommendationMenuResponse(
      {this.statusCode, this.message, this.errorCode, this.data});

  FoodRecommendationMenuResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DataFoodRecommendationMenuResponse>[];
      json['data'].forEach((v) {
        data!.add(new DataFoodRecommendationMenuResponse.fromJson(v));
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

class DataFoodRecommendationMenuResponse {
  List<Foods>? foods;
  double? recommendationScore;

  DataFoodRecommendationMenuResponse({this.foods, this.recommendationScore});

  DataFoodRecommendationMenuResponse.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods!.add(new Foods.fromJson(v));
      });
    }
    recommendationScore = json['recommendation_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foods != null) {
      data['foods'] = this.foods!.map((v) => v.toJson()).toList();
    }
    data['recommendation_score'] = this.recommendationScore;
    return data;
  }
}

class Foods {
  String? foodName;
  List<String>? foodTypes;
  List<FoodIngredientInfo>? foodIngredientInfo;
  List<FoodInstructionInfo>? foodInstructionInfo;
  int? duration;
  int? serving;
  String? difficulty;
  String? tags;
  String? creatorName;
  String? source;
  String? imageFilename;
  double? water;
  double? energy;
  double? protein;
  double? fat;
  double? carbohydrate;
  double? fiber;
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
  String? foodId;

  Foods(
      {this.foodName,
      this.foodTypes,
      this.foodIngredientInfo,
      this.foodInstructionInfo,
      this.duration,
      this.serving,
      this.difficulty,
      this.tags,
      this.creatorName,
      this.source,
      this.imageFilename,
      this.water,
      this.energy,
      this.protein,
      this.fat,
      this.carbohydrate,
      this.fiber,
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
      this.foodId});

  Foods.fromJson(Map<String, dynamic> json) {
    foodName = json['foodName'];
    foodTypes = json['foodTypes'].cast<String>();
    if (json['foodIngredientInfo'] != null) {
      foodIngredientInfo = <FoodIngredientInfo>[];
      json['foodIngredientInfo'].forEach((v) {
        foodIngredientInfo!.add(new FoodIngredientInfo.fromJson(v));
      });
    }
    if (json['foodInstructionInfo'] != null) {
      foodInstructionInfo = <FoodInstructionInfo>[];
      json['foodInstructionInfo'].forEach((v) {
        foodInstructionInfo!.add(new FoodInstructionInfo.fromJson(v));
      });
    }
    duration = json['duration'];
    serving = json['serving'];
    difficulty = json['difficulty'];
    tags = json['tags'];
    creatorName = json['creatorName'];
    source = json['source'];
    imageFilename = json['imageFilename'] != null ? json['imageFilename'] : '';
    water = json['water'];
    energy = json['energy'];
    protein = json['protein'];
    fat = json['fat'];
    carbohydrate = json['carbohydrate'];
    fiber = json['fiber'];
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
    foodId = json['foodId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foodName'] = this.foodName;
    data['foodTypes'] = this.foodTypes;
    if (this.foodIngredientInfo != null) {
      data['foodIngredientInfo'] =
          this.foodIngredientInfo!.map((v) => v.toJson()).toList();
    }
    if (this.foodInstructionInfo != null) {
      data['foodInstructionInfo'] =
          this.foodInstructionInfo!.map((v) => v.toJson()).toList();
    }
    data['duration'] = this.duration;
    data['serving'] = this.serving;
    data['difficulty'] = this.difficulty;
    data['tags'] = this.tags;
    data['creatorName'] = this.creatorName;
    data['source'] = this.source;
    if (this.imageFilename != null) {
      data['imageFilename'] = this.imageFilename;
    }
    data['water'] = this.water;
    data['energy'] = this.energy;
    data['protein'] = this.protein;
    data['fat'] = this.fat;
    data['carbohydrate'] = this.carbohydrate;
    data['fiber'] = this.fiber;
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
    data['foodId'] = this.foodId;
    return data;
  }
}

class FoodIngredientInfo {
  String? ingredientDescription;
  String? measurementDescription;
  int? ingredientIdFDA;
  double? quantity;
  String? measurement;
  int? ingredientIdTKPI;
  int? ingredientIdCustom;
  String? ingredientGroupName;
  List<IngredientsGroup>? ingredientsGroup;

  FoodIngredientInfo(
      {this.ingredientDescription,
      this.measurementDescription,
      this.ingredientIdFDA,
      this.quantity,
      this.measurement,
      this.ingredientIdTKPI,
      this.ingredientIdCustom,
      this.ingredientGroupName,
      this.ingredientsGroup});

  FoodIngredientInfo.fromJson(Map<String, dynamic> json) {
    ingredientDescription = json['ingredientDescription'];
    measurementDescription = json['measurementDescription'];
    ingredientIdFDA = json['ingredientIdFDA'];
    quantity = json['quantity'];
    measurement = json['measurement'];
    ingredientIdTKPI = json['ingredientIdTKPI'];
    ingredientIdCustom = json['ingredientIdCustom'];
    ingredientGroupName = json['ingredientGroupName'];
    if (json['ingredientsGroup'] != null) {
      ingredientsGroup = <IngredientsGroup>[];
      json['ingredientsGroup'].forEach((v) {
        ingredientsGroup!.add(new IngredientsGroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ingredientDescription'] = this.ingredientDescription;
    data['measurementDescription'] = this.measurementDescription;
    data['ingredientIdFDA'] = this.ingredientIdFDA;
    data['quantity'] = this.quantity;
    data['measurement'] = this.measurement;
    data['ingredientIdTKPI'] = this.ingredientIdTKPI;
    data['ingredientIdCustom'] = this.ingredientIdCustom;
    data['ingredientGroupName'] = this.ingredientGroupName;
    if (this.ingredientsGroup != null) {
      data['ingredientsGroup'] =
          this.ingredientsGroup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IngredientsGroup {
  int? ingredientIdTKPI;
  String? ingredientDescription;
  String? measurementDescription;
  double? quantity;
  String? measurement;
  int? ingredientIdCustom;
  int? ingredientIdFDA;

  IngredientsGroup(
      {this.ingredientIdTKPI,
      this.ingredientDescription,
      this.measurementDescription,
      this.quantity,
      this.measurement,
      this.ingredientIdCustom,
      this.ingredientIdFDA});

  IngredientsGroup.fromJson(Map<String, dynamic> json) {
    ingredientIdTKPI = json['ingredientIdTKPI'];
    ingredientDescription = json['ingredientDescription'];
    measurementDescription = json['measurementDescription'];
    quantity = json['quantity'];
    measurement = json['measurement'];
    ingredientIdCustom = json['ingredientIdCustom'];
    ingredientIdFDA = json['ingredientIdFDA'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ingredientIdTKPI'] = this.ingredientIdTKPI;
    data['ingredientDescription'] = this.ingredientDescription;
    data['measurementDescription'] = this.measurementDescription;
    data['quantity'] = this.quantity;
    data['measurement'] = this.measurement;
    data['ingredientIdCustom'] = this.ingredientIdCustom;
    data['ingredientIdFDA'] = this.ingredientIdFDA;
    return data;
  }
}

class FoodInstructionInfo {
  int? step;
  String? instruction;
  String? title;
  List<InstructionsGroup>? instructionsGroup;

  FoodInstructionInfo(
      {this.step, this.instruction, this.title, this.instructionsGroup});

  FoodInstructionInfo.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    instruction = json['instruction'];
    title = json['title'];
    if (json['instructionsGroup'] != null) {
      instructionsGroup = <InstructionsGroup>[];
      json['instructionsGroup'].forEach((v) {
        instructionsGroup!.add(new InstructionsGroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['step'] = this.step;
    data['instruction'] = this.instruction;
    data['title'] = this.title;
    if (this.instructionsGroup != null) {
      data['instructionsGroup'] =
          this.instructionsGroup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InstructionsGroup {
  int? step;
  String? instruction;

  InstructionsGroup({this.step, this.instruction});

  InstructionsGroup.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    instruction = json['instruction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['step'] = this.step;
    data['instruction'] = this.instruction;
    return data;
  }
}
