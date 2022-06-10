import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:objectbox/objectbox.dart';
import 'package:intl/intl.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:sirkadian_app/model/food_model/food_history_request_model.dart';
import 'package:sirkadian_app/model/food_model/food_history_response_model.dart';
import 'package:sirkadian_app/model/food_model/food_recommendation_response_model.dart';
import 'package:sirkadian_app/model/food_model/necessity_response_model.dart';
import 'package:sirkadian_app/provider/food_provider.dart';

import '../model/obejctbox_model.dart/food_exercise_model.dart';

class FoodController extends GetxController {
  final data = GetStorage('myData');
  final _provider = Get.put(FoodProvider());
  final informationController = Get.put(InformationController());
  final authController = Get.put(AuthController());

  //foods material
  RxList<DataFoodRecommendationResponse> listFood =
      <DataFoodRecommendationResponse>[].obs;
  RxList<DataFoodRecommendationResponse> listOtherFood =
      <DataFoodRecommendationResponse>[].obs;
  RxList<DataFoodHistoryResponse> listFoodHistory =
      <DataFoodHistoryResponse>[].obs;
  var isLoadingFoodRecommendation = false.obs;
  var isLoadingOtherFoodRecommendation = false.obs;
  var isLoadingNecessity = false.obs;
  var isLoadingFoodHistory = false.obs;

  var isOnFood = false.obs;

  //food session
  // final sessions = ['Sarapan', 'Makan Siang', 'Makan Malam', 'Snack'];
  final sessions = [
    'Sarapan',
    'Makan Siang',
    'Makan Malam',
  ];
  String getSessions(session) {
    return session == 'Sarapan'
        ? 'breakfast'
        : session == 'Makan Siang'
            ? 'lunch'
            : 'dinner';
  }

  var sessionSarapanClosed = false.obs;
  var sessionMakanSiangClosed = false.obs;
  var sessionMakanMalamClosed = false.obs;
  var sessionSarapanSucceed = false.obs;
  var sessionMakanSiangSucceed = false.obs;
  var sessionMakanMalamSucceed = false.obs;
  //nanti tambahin if date != date.now maka false
  void saveSession({
    String? session,
    String? date,
  }) async {
    if (session == 'Sarapan') {
      if (data.read('dataSessionSarapan') != null) {
        data.remove('dataSessionSarapan').then((_) => data.write(
            'dataSessionSarapan',
            {'sessionSarapan': sessionSarapanClosed.value, 'date': date}));
      } else {
        data.write('dataSessionSarapan',
            {'sessionSarapan': sessionSarapanClosed.value, 'date': date});
      }
    } else if (session == 'Makan Siang') {
      if (data.read('dataSessionMakanSiang') != null) {
        data.remove('dataSessionMakanSiang').then((_) => data.write(
                'dataSessionMakanSiang', {
              'sessionMakanSiang': sessionMakanSiangClosed.value,
              'date': date
            }));
      } else {
        data.write('dataSessionMakanSiang',
            {'sessionMakanSiang': sessionMakanSiangClosed.value, 'date': date});
      }
    } else {
      if (data.read('dataSessionMakanMalam') != null) {
        data.remove('dataSessionMakanMalam').then((_) => data.write(
                'dataSessionMakanMalam', {
              'sessionMakanMalam': sessionMakanMalamClosed.value,
              'date': date
            }));
      } else {
        data.write('dataSessionMakanMalam',
            {'sessionMakanMalam': sessionMakanMalamClosed.value, 'date': date});
      }
    }
  }

  //food recommendation material
  var isLoadingNewPage = false.obs;
  var page = 1.obs;

  //necessity material
  var necessity = DataNecessityResponse().obs;

  var listMealSarapan = <Food>[].obs;
  var listMealMakanSiang = <Food>[].obs;
  var listMealMakanMalam = <Food>[].obs;
  var listMealSnack = <Food>[].obs;
  double energy = 0;
  double energySarapan = 0;
  double energyMakanSiang = 0;
  double energyMakanMalam = 0;
  double protein = 0;
  double proteinSarapan = 0;
  double proteinMakanSiang = 0;
  double proteinMakanMalam = 0;
  double fat = 0;
  double fatSarapan = 0;
  double fatMakanSiang = 0;
  double fatMakanMalam = 0;
  double carbohydrate = 0;
  double carbohydrateSarapan = 0;
  double carbohydrateMakanSiang = 0;
  double carbohydrateMakanMalam = 0;
  double fiber = 0;
  double fiberSarapan = 0;
  double fiberMakanSiang = 0;
  double fiberMakanMalam = 0;
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
  late String startDate;
  late String endDate;
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
    var dateStart = new DateTime.utc(2022, 1, 1);
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    String formattedDate = serverFormater.format(dateStart);
    String finalDate = formattedDate.toString();
    //
    var dateEnd = new DateTime.utc(2022, 12, 30);

    String formattedDateEnd = serverFormater.format(dateEnd);
    String finalDateEnd = formattedDateEnd.toString();

    var dateNow = new DateTime.now();
    String formattedDateNow = serverFormater.format(dateNow);
    String finalDateNow = formattedDateNow.toString();

    startDate = finalDate;
    endDate = finalDateEnd;
    dateNoww = finalDateNow;
  }

//provider controller material
  Future<void> getFoodRecommendation(String session) async {
    isLoadingFoodRecommendation(true);
    await authController.getUsableToken();
    var foodTime = session == 'Sarapan'
        ? 'breakfast'
        : session == 'Makan Siang'
            ? 'lunch'
            : 'dinner';
    try {
      String accessToken = data.read('dataUser')['accessToken'];
      var _res = await _provider.getFoodRecommendation(
          accessToken, foodTime, page.value);
      print(_res.statusCode);

      if (_res.statusCode == 200) {
        FoodRecommendationResponse _foodRecommendationResponse =
            FoodRecommendationResponse.fromJson(
                _res.body as Map<String, dynamic>);
        if (_foodRecommendationResponse.statusCode == 200) {
          listFood.value = _foodRecommendationResponse.data!;
        }
      }

      if (Get.isDialogOpen!) Get.back();
    } finally {
      isLoadingFoodRecommendation(false);
    }
  }

  Future<void> getOtherFoodRecommendation(foodId, session) async {
    isLoadingOtherFoodRecommendation(true);
    await authController.getUsableToken();
    var foodTime = session == 'Sarapan'
        ? 'breakfast'
        : session == 'Makan Siang'
            ? 'lunch'
            : 'dinner';
    try {
      String accessToken = data.read('dataUser')['accessToken'];
      var _res = await _provider.getOtherFoodRecommendation(
          accessToken, foodId, foodTime);
      print(_res.statusCode);
      if (_res.statusCode == 200) {
        FoodRecommendationResponse _foodRecommendationResponse =
            FoodRecommendationResponse.fromJson(
                _res.body as Map<String, dynamic>);
        if (_foodRecommendationResponse.statusCode == 200) {
          listOtherFood.value = _foodRecommendationResponse.data!;
        }
      }

      if (Get.isDialogOpen!) Get.back();
    } finally {
      isLoadingOtherFoodRecommendation(false);
    }
  }

  Future<void> getFoodRecommendationNewPage(String session) async {
    isLoadingNewPage(true);
    await authController.getUsableToken();
    page.value = page.value + 1;

    var foodTime = session == 'Sarapan'
        ? 'breakfast'
        : session == 'Makan Siang'
            ? 'lunch'
            : 'dinner';
    try {
      String accessToken = data.read('dataUser')['accessToken'];
      var _res = await _provider.getFoodRecommendation(
          accessToken, foodTime, page.value);
      print(_res.statusCode);
      if (_res.statusCode == 200) {
        FoodRecommendationResponse _foodRecommendationResponse =
            FoodRecommendationResponse.fromJson(
                _res.body as Map<String, dynamic>);
        if (_foodRecommendationResponse.statusCode == 200) {
          listFood = listFood + _foodRecommendationResponse.data!;
        }
      } else {
        page = page - 1;
        Future.delayed(Duration(seconds: 10), () {
          isLoadingNewPage(false);
        });
      }

      if (Get.isDialogOpen!) Get.back();
    } finally {
      isLoadingNewPage(false);
      update();
    }
  }

  Future<void> getFoodHistory() async {
    isLoadingFoodHistory(true);
    await authController.getUsableToken();
    getDateTime();

    try {
      String accessToken = data.read('dataUser')['accessToken'];
      var _res = await _provider.getFoodHistory(
          accessToken: accessToken, endDate: endDate, startDate: startDate);
      print(_res.statusCode);
      if (_res.statusCode == 200) {
        FoodHistoryResponse _foodHistoryResponse =
            FoodHistoryResponse.fromJson(_res.body as Map<String, dynamic>);
        if (_foodHistoryResponse.statusCode == 200) {
          listFoodHistory.value = _foodHistoryResponse.data!;
          listFoodHistory.forEach((element) {
            element.isOpen = false;
            update();
          });
        }
      }

      if (Get.isDialogOpen!) Get.back();
    } finally {
      isLoadingFoodHistory(false);
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

  //post method
  Future<bool> postFoodHistory(
      {FoodHistoryRequest? foodHistoryRequest, String? session}) async {
    if (foodHistoryRequest!.foodDate != null &&
        foodHistoryRequest.foodTime != null &&
        foodHistoryRequest.foods != null) {
      await authController.getUsableToken();
      informationController
          .loadingDialog('Harap Menunggu, Sedang Menyimpan Makanan ke Server');
      try {
        String accessToken = data.read('dataUser')['accessToken'];
        final Response _res =
            await _provider.postFoodHistory(accessToken, foodHistoryRequest);
        if (_res.statusCode == 200) {
          if (Get.isDialogOpen!) Get.back();
          informationController.showSuccessSnackBar('Berhasil');

          if (session == 'Sarapan') {
            sessionSarapanSucceed(true);

            update();
          } else if (session == 'Makan Siang') {
            sessionMakanSiangSucceed(true);

            update();
          } else {
            sessionMakanMalamSucceed(true);

            update();
          }
        } else {
          if (Get.isDialogOpen!) Get.back();
          informationController.showErrorSnackBar('Gagal');
          print('error' + _res.statusCode.toString());
        }
      } catch (e) {
        e.toString();
        if (Get.isDialogOpen!) Get.back();
        informationController
            .showErrorSnackBar('terjadi masalah, harap ulangi');

        print(e);
      }
    } else {
      if (Get.isDialogOpen!) Get.back();
    }
    if (session == 'Sarapan') {
      return sessionSarapanSucceed.value;
    } else if (session == 'Makan Siang') {
      return sessionMakanSiangSucceed.value;
    } else {
      return sessionMakanMalamSucceed.value;
    }
  }
}
