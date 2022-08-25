// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class HealthwareController extends GetxController {
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

  // bluetooth material
  // RxList<BluetoothDevice> listBluetooth = <BluetoothDevice>[].obs;
}
