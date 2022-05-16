import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:objectbox/objectbox.dart';
import 'package:intl/intl.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:sirkadian_app/model/food_model/foodAll_response_model.dart';
import 'package:sirkadian_app/model/food_model/necessity_response_model.dart';
import 'package:sirkadian_app/provider/food_provider.dart';

import '../model/obejctbox_model.dart/food_model.dart';

class FoodController extends GetxController {
  final data = GetStorage('myData');
  final _provider = Get.put(FoodProvider());
  final informationController = Get.put(InformationController());
  final authController = Get.put(AuthController());
  final sessions = ['Sarapan', 'Makan Siang', 'Makan Malam', 'Snack'];

  //foods material
  final listFood = <DataFoodAllResponse>[].obs;

  final isLoadingFoodAll = false.obs;
  final isLoadingNecessity = false.obs;
  final isOnFood = false.obs;

  //necessity material
  var necessity = DataNecessityResponse().obs;

  var listMealSarapan = <Food>[].obs;
  var listMealMakanSiang = <Food>[].obs;
  var listMealMakanMalam = <Food>[].obs;
  var listMealSnack = <Food>[].obs;
  double energy = 0;
  double protein = 0;
  double fat = 0;
  double carbohydrate = 0;
  double fiber = 0;
  double water = 0;
  double sodium = 0;
  double calcium = 0;
  double iron = 0;
  double phosphor = 0;
  double potassium = 0;
  double zinc = 0;
  double copper = 0;
  double vitaminC = 0;
  double vitaminB1 = 0;
  double vitaminB2 = 0;
  double vitaminB3 = 0;
  double retinol = 0;

  //objectbox material
  late Store foodStore;

  var hasBeenInitialized = false.obs;

  //date material
  late String dateStartt;
  late String dateEndd;
  late String dateNoww;
  var selectedDay = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var focusedDay = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String date = (DateTime.now().year.toString() +
      '-' +
      DateTime.now().month.toString() +
      '-' +
      DateTime.now().day.toString());
  void getDateTime() {
    var dateStart = new DateTime.utc(2021, 12, 1);
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    String formattedDate = serverFormater.format(dateStart);
    String finalDate = formattedDate.toString();
    //
    var dateEnd = new DateTime.utc(2022, 12, 1);

    String formattedDateEnd = serverFormater.format(dateEnd);
    String finalDateEnd = formattedDateEnd.toString();

    var dateNow = new DateTime.now();
    String formattedDateNow = serverFormater.format(dateNow);
    String finalDateNow = formattedDateNow.toString();

    dateStartt = finalDate;
    dateEndd = finalDateEnd;
    dateNoww = finalDateNow;
  }

//provider controller material
  Future<void> getFoodAll() async {
    isLoadingFoodAll(true);
    await authController.getUsableToken();
    try {
      String accessToken = data.read('dataUser')['accessToken'];
      var _res = await _provider.getAllFood(accessToken);
      if (_res.statusCode == 200) {
        FoodAllResponse _foodAllResponse =
            FoodAllResponse.fromJson(_res.body as Map<String, dynamic>);
        if (_foodAllResponse.statusCode == 200) {
          listFood.value = _foodAllResponse.data!;
        }
      }

      if (Get.isDialogOpen!) Get.back();
    } finally {
      isLoadingFoodAll(false);
    }
  }

  Future<void> getNecessity() async {
    isLoadingNecessity(true);
    await authController.getUsableToken();

    try {
      String accessToken = data.read('dataUser')['accessToken'];
      var _res = await _provider.getNecessity(accessToken);
      print(_res.statusCode);
      if (_res.statusCode == 200) {
        print(_res.body);
        NecessityResponse _necessityResponse =
            NecessityResponse.fromJson(_res.body as Map<String, dynamic>);

        if (_necessityResponse.statusCode == 200) {
          print(_necessityResponse.data);
          necessity.value = _necessityResponse.data!;
        }
      }

      if (Get.isDialogOpen!) Get.back();
    } finally {
      isLoadingNecessity(false);
    }
  }
}
