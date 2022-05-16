import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'auth_controller.dart';
import 'information_controller.dart';

class FluidController extends GetxController {
  final authController = Get.put(AuthController());
  final informationController = Get.put(InformationController());
  final data = GetStorage('myData');
  final isLoadingSubscriptionAll = false.obs;

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

//drink waster material
  var isCheckedDrinkWater =
      [false, false, false, false, false, false, false, false].obs;

//api material
//get method

  //post method

}
