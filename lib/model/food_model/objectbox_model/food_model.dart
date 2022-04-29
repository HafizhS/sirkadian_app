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
  int? foodId;
  List<String>? instruction;
  String? imageFileName;

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
    required this.instruction,
    required this.imageFileName,
  });
}

@Entity()
class User {
  int id;

  @Backlink()
  final foods = ToMany<Food>();

  User({
    this.id = 0,
  });
}
