import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sirkadian_app/model/exercise_model/exerciseAll_response_model.dart';
import 'package:sirkadian_app/model/exercise_model/exercise_history_request_model.dart';
import 'package:sirkadian_app/provider/exercise_provider.dart';
import 'hexcolor_controller.dart';
import '../model/exercise_model/exercise_history_post_response_model.dart';
import '../objectbox.g.dart';
import '../screen/home/exercise_screen/exercise_general_screen.dart';
import 'auth_controller.dart';
import 'information_controller.dart';

class ExerciseController extends GetxController {
  final authController = Get.put(AuthController());
  final _provider = Get.put(ExerciseProvider());
  final color = Get.put(ColorConstantController());
  final informationController = Get.put(InformationController());
  final data = GetStorage('myData');
  final isLoadingSubscriptionAll = false.obs;

//objectbox material / getstorage material
  late Store exerciseStore;
  var sessionExerciseClosed =
      false.obs; //nanti tambahin if date != date.now maka false
  void saveSession() async {
    if (data.read('dataSessionExercise') != null) {
      data
          .remove('dataSessionExercise')
          .then((_) => data.write('dataSessionExercise', {
                'sessionExercise': sessionExerciseClosed.value,
              }));
      print('here');
    } else {
      data.write('dataSessionExercise', {
        'sessionExercise': sessionExerciseClosed.value,
      });
    }
  }

  //dependencies
  var isCheckExerciseTile = false.obs;

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

  List<ExerciseGaugeModel> weekDays = [];
  var selectedDayGauge = DateTime.now();
  String month = 'Januari';
  void getDatePerWeek() {
    // dateSelected = DateTime.now();
    if (selectedDayGauge.day.isLowerThan(8)) {
      weekDays = [
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '70%', day: '1', value: 170),
        ExerciseGaugeModel(
            color: color.greenColor, stringValue: '20%', day: '2', value: 40),
        ExerciseGaugeModel(
            color: color.blueColor, stringValue: '50%', day: '3', value: 130),
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '40%', day: '4', value: 80),
        ExerciseGaugeModel(
            color: color.greenColor, stringValue: '100%', day: '5', value: 200),
        ExerciseGaugeModel(
            color: color.blueColor, stringValue: '30%', day: '6', value: 100),
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '0%', day: '7', value: 0),
      ];
      update();
    } else if (selectedDayGauge.day.isLowerThan(15)) {
      weekDays = [
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '70%', day: '8', value: 120),
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '70%', day: '9', value: 120),
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '70%', day: '10', value: 120),
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '70%', day: '11', value: 120),
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '70%', day: '12', value: 120),
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '70%', day: '13', value: 120),
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '70%', day: '14', value: 120),
      ];
      update();
    } else if (selectedDayGauge.day.isLowerThan(22)) {
      weekDays = [
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '70%', day: '15', value: 120),
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '70%', day: '16', value: 120),
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '70%', day: '17', value: 120),
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '70%', day: '18', value: 120),
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '70%', day: '19', value: 120),
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '70%', day: '20', value: 120),
        ExerciseGaugeModel(
            color: color.redColor, stringValue: '70%', day: '21', value: 120),
      ];
      update();
    } else {
      if (DateTime.now().month == DateTime.february) {
        weekDays = [
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '22', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '23', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '24', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '25', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '26', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '27', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '28', value: 120),
        ];
      } else if (DateTime.now().month ==
          DateTime.january |
              DateTime.march |
              DateTime.may |
              DateTime.august |
              DateTime.october |
              DateTime.december) {
        weekDays = [
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '22', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '23', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '24', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '25', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '26', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '27', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '28', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '29', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '30', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '31', value: 120),
        ];
      } else {
        weekDays = [
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '22', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '23', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '24', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '25', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '26', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '27', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '28', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '29', value: 120),
          ExerciseGaugeModel(
              color: color.redColor, stringValue: '70%', day: '30', value: 120),
        ];
      }
      update();
    }
    ;
  }

  void getMonth() {
    switch (selectedDayGauge.month) {
      case 1:
        month = 'Januari';
        update();
        break;
      case 2:
        month = 'Februari';
        update();
        break;
      case 3:
        month = 'Maret';
        update();
        break;
      case 4:
        month = 'April';
        update();
        break;
      case 5:
        month = 'Mei';
        update();
        break;
      case 6:
        month = 'Juni';
        update();
        break;
      case 7:
        month = 'Juli';
        update();
        break;
      case 8:
        month = 'Agustus';
        update();
        break;
      case 9:
        month = 'September';
        update();
        break;
      case 10:
        month = 'Oktober';
        update();
        break;
      case 11:
        month = 'November';
        update();
        break;
      case 12:
        month = 'Desember';
        update();
        break;
      default:
    }
  }

//api material
//get method
  final listExercise = <DataExerciseAllResponse>[].obs;
  Future<void> getAllExercise() async {
    isLoadingSubscriptionAll(true);
    await authController.getUsableToken();
    try {
      String accessToken = data.read('dataUser')['accessToken'];
      var _res = await _provider.getAllExercise(accessToken);

      if (_res.statusCode == 200) {
        ExerciseAllResponse _exerciseAllResponse =
            ExerciseAllResponse.fromJson(_res.body as Map<String, dynamic>);

        if (_exerciseAllResponse.statusCode == 200) {
          listExercise.value = _exerciseAllResponse.data!;
        }
      }

      if (Get.isDialogOpen!) Get.back();
    } finally {
      isLoadingSubscriptionAll(false);
    }
  }

  //post method
  Future<void> postExerciseHistory(
      {ExerciseHistoryRequest? exerciseHistoryRequest}) async {
    if (exerciseHistoryRequest!.sports!.isNotEmpty &&
        exerciseHistoryRequest.sportDate != '') {
      informationController.loadingDialog('');
      try {
        String accessToken = data.read('dataUser')['accessToken'];
        final Response _res = await _provider.postHistoryExercise(
            accessToken: accessToken,
            exerciseHistoryRequest: exerciseHistoryRequest);
        if (_res.statusCode == 200) {
          ExerciseHistoryPostResponse _exerciseHistoryRequest =
              ExerciseHistoryPostResponse.fromJson(
                  _res.body as Map<String, dynamic>);

          if (Get.isDialogOpen!) Get.back();

          if (_exerciseHistoryRequest.statusCode == 200) {
            print('post exercise success');
          }
        } else if (_res.statusCode == 500) {
          print('error sc 500');
        } else {
          print(_res.statusCode);
          print(_res.body);
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
      informationController.snackBarError("Data Tidak Lengkap",
          "silakan isi semua data pribadi Anda terlebih dahulu");
    }
  }
}
