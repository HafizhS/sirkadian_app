class FoodHistoryResponse {
  int? statusCode;
  String? message;
  String? errorCode;
  List<DataFoodHistoryResponse>? data;

  FoodHistoryResponse(
      {this.statusCode, this.message, this.errorCode, this.data});

  FoodHistoryResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    errorCode = json['errorCode'] != null ? json['errorCode'] : '';
    if (json['data'] != null) {
      final history = json['data']
          .fold(
              {},
              (a, b) => {
                    ...a,
                    b['foodDate']: [b, ...?a[b['foodDate']]],
                  })
          .values
          .where((l) => l.isNotEmpty == true)
          .map((l) => {'foodDate': l.first['foodDate'], 'historyList': l})
          .toList();

      data = [];
      history.forEach((v) {
        data!.add(new DataFoodHistoryResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = new Map<String, dynamic>();
    _data['statusCode'] = statusCode;
    _data['message'] = message;
    _data['errorCode'] = errorCode;
    if (this.data != null) {
      _data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return _data;
  }
}

class DataFoodHistoryResponse {
  String? foodDate;
  bool? isOpen;
  List<DataChildFoodHistoryResponse>? historyList;
  DataFoodHistoryResponse({
    this.foodDate,
    this.historyList,
    this.isOpen,
  });

  DataFoodHistoryResponse.fromJson(Map<String, dynamic> json) {
    foodDate = json['foodDate'];
    if (json['historyList'] != null) {
      historyList = [];
      json['historyList'].forEach((v) {
        historyList!.add(new DataChildFoodHistoryResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['foodDate'] = this.foodDate;
    if (this.historyList != null) {
      data['historyList'] = this.historyList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataChildFoodHistoryResponse {
  List<Foods>? foods;
  String? foodTime;

  double? totalWater;
  double? totalEnergy;
  double? totalProtein;
  double? totalFat;
  double? totalCarbohydrate;
  double? totalFiber;
  double? totalCalcium;
  double? totalIron;
  double? totalPhospor;
  double? totalPotassium;
  double? totalSodium;
  double? totalZinc;
  double? totalCopper;
  double? totalVitC;
  double? totalVitB1;
  double? totalVitB2;
  double? totalVitB3;
  double? totalRetinol;

  DataChildFoodHistoryResponse(
      {this.foods,
      this.foodTime,
      this.totalWater,
      this.totalEnergy,
      this.totalProtein,
      this.totalFat,
      this.totalCarbohydrate,
      this.totalFiber,
      this.totalCalcium,
      this.totalIron,
      this.totalPhospor,
      this.totalPotassium,
      this.totalSodium,
      this.totalZinc,
      this.totalCopper,
      this.totalVitC,
      this.totalVitB1,
      this.totalVitB2,
      this.totalVitB3,
      this.totalRetinol});

  DataChildFoodHistoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = [];
      json['foods'].forEach((v) {
        foods!.add(new Foods.fromJson(v));
      });
    }
    foodTime = json['foodTime'];

    totalWater = json['totalWater'];
    totalEnergy = json['totalEnergy'];
    totalProtein = json['totalProtein'];
    totalFat = json['totalFat'];
    totalCarbohydrate = json['totalCarbohydrate'];
    totalFiber = json['totalFiber'];
    totalCalcium = json['totalCalcium'];
    totalIron = json['totalIron'];
    totalPhospor = json['totalPhospor'];
    totalPotassium = json['totalPotassium'];
    totalSodium = json['totalSodium'];
    totalZinc = json['totalZinc'];
    totalCopper = json['totalCopper'];
    totalVitC = json['totalVitC'];
    totalVitB1 = json['totalVitB1'];
    totalVitB2 = json['totalVitB2'];
    totalVitB3 = json['totalVitB3'];
    totalRetinol = json['totalRetinol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foods != null) {
      data['foods'] = this.foods!.map((v) => v.toJson()).toList();
    }
    data['foodTime'] = this.foodTime;

    data['totalWater'] = this.totalWater;
    data['totalEnergy'] = this.totalEnergy;
    data['totalProtein'] = this.totalProtein;
    data['totalFat'] = this.totalFat;
    data['totalCarbohydrate'] = this.totalCarbohydrate;
    data['totalFiber'] = this.totalFiber;
    data['totalCalcium'] = this.totalCalcium;
    data['totalIron'] = this.totalIron;
    data['totalPhospor'] = this.totalPhospor;
    data['totalPotassium'] = this.totalPotassium;
    data['totalSodium'] = this.totalSodium;
    data['totalZinc'] = this.totalZinc;
    data['totalCopper'] = this.totalCopper;
    data['totalVitC'] = this.totalVitC;
    data['totalVitB1'] = this.totalVitB1;
    data['totalVitB2'] = this.totalVitB2;
    data['totalVitB3'] = this.totalVitB3;
    data['totalRetinol'] = this.totalRetinol;
    return data;
  }
}

class Foods {
  FoodItem? food;
  double? portion;

  Foods({this.food, this.portion});

  Foods.fromJson(Map<String, dynamic> json) {
    food = json['food'] != null ? new FoodItem.fromJson(json['food']) : null;
    portion = json['portion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food'] = this.food!.toJson();
    data['portion'] = this.portion;
    return data;
  }
}

class FoodItem {
  String? foodName;
  List<String>? foodTypes;
  String? imageFilename;
  List<FoodIngredientInfo>? foodIngredientInfo;
  List<FoodInstructionInfo>? foodInstructionInfo;
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
  String? foodId;

  FoodItem(
      {this.foodName,
      this.foodTypes,
      this.imageFilename,
      this.foodIngredientInfo,
      this.foodInstructionInfo,
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

  FoodItem.fromJson(Map<String, dynamic> json) {
    foodName = json['foodName'];
    foodTypes = json['foodTypes'].cast<String>();
    imageFilename = json['imageFilename'] != null ? json['imageFilename'] : '';
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
    data['imageFilename'] = this.imageFilename;
    data['foodIngredientInfo'] =
        this.foodIngredientInfo!.map((v) => v.toJson()).toList();
    data['foodInstructionInfo'] =
        this.foodInstructionInfo!.map((v) => v.toJson()).toList();
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
  int? ingredientIdTKPI;
  double? quantity;
  String? measurement;
  int? ingredientIdFDA;
  String? ingredientGroupName;
  List<IngredientsGroup>? ingredientsGroup;

  FoodIngredientInfo(
      {this.ingredientDescription,
      this.measurementDescription,
      this.ingredientIdTKPI,
      this.quantity,
      this.measurement,
      this.ingredientIdFDA,
      this.ingredientGroupName,
      this.ingredientsGroup});

  FoodIngredientInfo.fromJson(Map<String, dynamic> json) {
    ingredientDescription = json['ingredientDescription'];
    measurementDescription = json['measurementDescription'];
    ingredientIdTKPI = json['ingredientIdTKPI'];
    quantity = json['quantity'];
    measurement = json['measurement'];
    ingredientIdFDA = json['ingredientIdFDA'];
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
    data['ingredientIdTKPI'] = this.ingredientIdTKPI;
    data['quantity'] = this.quantity;
    data['measurement'] = this.measurement;
    data['ingredientIdFDA'] = this.ingredientIdFDA;
    data['ingredientGroupName'] = this.ingredientGroupName;
    data['ingredientsGroup'] =
        this.ingredientsGroup!.map((v) => v.toJson()).toList();
    return data;
  }
}

class IngredientsGroup {
  int? ingredientIdTKPI;
  String? ingredientDescription;
  String? measurementDescription;
  double? quantity;
  String? measurement;
  int? ingredientIdFDA;

  IngredientsGroup(
      {this.ingredientIdTKPI,
      this.ingredientDescription,
      this.measurementDescription,
      this.quantity,
      this.measurement,
      this.ingredientIdFDA});

  IngredientsGroup.fromJson(Map<String, dynamic> json) {
    ingredientIdTKPI = json['ingredientIdTKPI'];
    ingredientDescription = json['ingredientDescription'];
    measurementDescription = json['measurementDescription'];
    quantity = json['quantity'];
    measurement = json['measurement'];
    ingredientIdFDA = json['ingredientIdFDA'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ingredientIdTKPI'] = this.ingredientIdTKPI;
    data['ingredientDescription'] = this.ingredientDescription;
    data['measurementDescription'] = this.measurementDescription;
    data['quantity'] = this.quantity;
    data['measurement'] = this.measurement;
    data['ingredientIdFDA'] = this.ingredientIdFDA;
    return data;
  }
}

class FoodInstructionInfo {
  int? step;
  String? instruction;

  FoodInstructionInfo({this.step, this.instruction});

  FoodInstructionInfo.fromJson(Map<String, dynamic> json) {
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
