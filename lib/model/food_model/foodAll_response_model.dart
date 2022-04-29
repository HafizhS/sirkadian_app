class FoodAllResponse {
  int? statusCode;
  String? message;
  Null errorCode;
  List<DataFoodAllResponse>? data;

  FoodAllResponse({this.statusCode, this.message, this.errorCode, this.data});

  FoodAllResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new DataFoodAllResponse.fromJson(v));
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

class DataFoodAllResponse {
  String? foodName;
  List<String>? foodTypes;
  List<FoodIngredientInfo>? foodIngredientInfo;
  List<FoodInstructionInfo>? foodInstructionInfo;
  String? imageFilename;
  int? duration;
  int? serving;
  String? difficulty;
  String? tags;
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
  int? foodId;

  DataFoodAllResponse(
      {this.foodName,
      this.foodTypes,
      this.foodIngredientInfo,
      this.foodInstructionInfo,
      this.imageFilename,
      this.duration,
      this.serving,
      this.difficulty,
      this.tags,
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

  DataFoodAllResponse.fromJson(Map<String, dynamic> json) {
    foodName = json['foodName'];
    foodTypes = json['foodTypes'].cast<String>();
    if (json['foodIngredientInfo'] != null) {
      foodIngredientInfo = [];
      json['foodIngredientInfo'].forEach((v) {
        foodIngredientInfo!.add(new FoodIngredientInfo.fromJson(v));
      });
    }
    if (json['foodInstructionInfo'] != null) {
      foodInstructionInfo = [];
      json['foodInstructionInfo'].forEach((v) {
        foodInstructionInfo!.add(new FoodInstructionInfo.fromJson(v));
      });
    }
    imageFilename = json['imageFilename'];
    duration = json['duration'];
    serving = json['serving'];
    difficulty = json['difficulty'];
    tags = json['tags'];
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
    data['imageFilename'] = this.imageFilename;
    data['duration'] = this.duration;
    data['serving'] = this.serving;
    data['difficulty'] = this.difficulty;
    data['tags'] = this.tags;
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
  String? ingredientGroupName;
  List<IngredientsGroup>? ingredientsGroup;

  FoodIngredientInfo({
    this.ingredientsGroup,
    this.ingredientGroupName,
    this.ingredientDescription,
    this.measurementDescription,
    this.ingredientIdFDA,
    this.quantity,
    this.measurement,
  });

  FoodIngredientInfo.fromJson(Map<String, dynamic> json) {
    ingredientDescription = json['ingredientDescription'];
    measurementDescription = json['measurementDescription'];
    ingredientIdFDA = json['ingredientIdFDA'];
    quantity = json['quantity'];
    measurement = json['measurement'];
    ingredientGroupName = json['ingredientGroupName'];
    if (json['ingredientsGroup'] != null) {
      ingredientsGroup = [];
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
    data['ingredientGroupName'] = this.ingredientGroupName;
    if (this.ingredientsGroup != null) {
      data['ingredientsGroup'] =
          this.ingredientsGroup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IngredientsGroup {
  int? ingredientIdFDA;
  String? ingredientDescription;
  String? measurementDescription;
  double? quantity;
  String? measurement;

  IngredientsGroup(
      {this.ingredientIdFDA,
      this.ingredientDescription,
      this.measurementDescription,
      this.quantity,
      this.measurement});

  IngredientsGroup.fromJson(Map<String, dynamic> json) {
    ingredientIdFDA = json['ingredientIdFDA'];
    ingredientDescription = json['ingredientDescription'];
    measurementDescription = json['measurementDescription'];
    quantity = json['quantity'];
    measurement = json['measurement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ingredientIdFDA'] = this.ingredientIdFDA;
    data['ingredientDescription'] = this.ingredientDescription;
    data['measurementDescription'] = this.measurementDescription;
    data['quantity'] = this.quantity;
    data['measurement'] = this.measurement;
    return data;
  }
}

class FoodInstructionInfo {
  int? step;
  String? instruction;
  String? title;
  List<InstructionsGroup>? instructionsGroup;

  FoodInstructionInfo({this.step, this.instruction});

  FoodInstructionInfo.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    instruction = json['instruction'];
    title = json['title'];
    if (json['instructionsGroup'] != null) {
      instructionsGroup = [];
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

  InstructionsGroup({
    this.step,
    this.instruction,
  });

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
