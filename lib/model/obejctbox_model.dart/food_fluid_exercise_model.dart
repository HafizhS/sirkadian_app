import 'package:objectbox/objectbox.dart';

@Entity()
class Food {
  int id;
  String? name;
  List<String>? foodTypes;
  int? duration;
  int? serving;
  String session;
  String date;
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
  String? itemFood;
  String? imageFileName;
  String? recommendationScore;

  final user = ToOne<User>();
  Food({
    this.id = 0,
    required this.name,
    required this.foodTypes,
    required this.duration,
    required this.serving,
    required this.date,
    required this.session,
    required this.difficulty,
    required this.tags,
    required this.water,
    required this.energy,
    required this.protein,
    required this.fat,
    required this.carbohydrate,
    required this.fiber,
    required this.calcium,
    required this.iron,
    required this.phosphor,
    required this.potassium,
    required this.sodium,
    required this.zinc,
    required this.copper,
    required this.vitaminC,
    required this.vitaminB1,
    required this.vitaminB2,
    required this.vitaminB3,
    required this.retinol,
    required this.foodId,
    required this.itemFood,
    required this.imageFileName,
    required this.recommendationScore,
  });
}

@Entity()
class Fluid {
  int id;
  double? amountWater;
  double? sum;
  double? size;
  String? fluidTime;
  String? date;
  bool? isChecked;

  final user = ToOne<User>();
  Fluid({
    this.id = 0,
    required this.amountWater,
    required this.sum,
    required this.size,
    required this.fluidTime,
    required this.date,
    required this.isChecked,
  });
}

@Entity()
class Exercise {
  int id;
  int? sportId;
  String? name;
  String? desc;
  String? difficulty;
  double? mets;
  // List<Variations>? variations;
  String? date;
  String? imageFilename;
  bool? isChecked;

  final user = ToOne<User>();
  Exercise({
    this.id = 0,
    required this.name,
    required this.desc,
    required this.difficulty,
    required this.imageFilename,
    required this.mets,
    required this.sportId,
    required this.date,
    required this.isChecked,

    // required this.variations,
  });
}

@Entity()
class Variations {
  int id;
  int? sportId;
  int? sportVariationsId;
  String? name;
  String? difficulty;
  String? desc;
  double? mets;
  String? subVariations;
  String? imageFilename;

  final user = ToOne<Exercise>();
  Variations({
    this.id = 0,
    required this.name,
    required this.difficulty,
    required this.desc,
    required this.imageFilename,
    required this.mets,
    required this.sportId,
    required this.subVariations,
    required this.sportVariationsId,
  });
}

@Entity()
class User {
  int id;

  @Backlink()
  final foods = ToMany<Food>();
  final fluids = ToMany<Fluid>();
  final exercises = ToMany<Exercise>();

  User({
    this.id = 0,
  });
}

@Entity()
class UserLogNutrition {
  int id;
  double? nutrition;
  double? water;
  String? date;
  String? foodId;
  final user = ToOne<User>();
  UserLogNutrition({
    this.id = 0,
    required this.nutrition,
    required this.date,
    required this.foodId,
    required this.water,
  });
}