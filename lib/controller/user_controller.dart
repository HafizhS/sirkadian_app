import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sirkadian_app/model/user_model/user_health_historyLatest_response_model.dart';
import 'package:sirkadian_app/model/user_model/user_health_history_request_model.dart';
import 'package:sirkadian_app/model/user_model/user_health_preferenceLatest_response_model.dart';
import 'package:sirkadian_app/model/user_model/user_health_preference_request_model.dart';
import 'package:sirkadian_app/model/user_model/user_information_response_model.dart';

import '../objectbox.g.dart';
import '../provider/user_provider.dart';
import 'auth_controller.dart';
import 'information_controller.dart';

class UserController extends GetxController {
  final _provider = Get.put(UserProvider());
  final authController = Get.put(AuthController());
  final informationController = Get.put(InformationController());
  final data = GetStorage('myData');
  var isLoadingUserHealthPreferenceLatest = false.obs;
  var isLoadingUserHealthHistoryLatest = false.obs;
  var isLoadingUserInformation = false.obs;
  var userHealthPreferenceLatestResponse =
      DataUserHealthPreferenceLatestResponse().obs;
  var userHealthHistoryLatestResponse =
      DataUserHealthHistoryLatestResponse().obs;
  var userInformationResponse = DataUserInformationResponse().obs;

  // alergi -------------------------------------------------------

  // riwayat penyakit -----------------------------------------------

  // kebutuhan initial setup -----------------------------------------------
  DateTime date = DateTime.now();

  List<String> jenisKelamin = [
    'female',
    'male',
  ];
  int jenisKelaminIndex = 0;
  List<bool> veganListBool = [true, false];
  List<String> vegan = [
    'Ya',
    'Tidak',
  ];
  int veganIndex = 0;

  List<String> tingkatAktivitas = ['sedentary', 'low', 'medium', 'high'];

  int tingkatAktivitasIndex = 0;
  List<String> levelOlahraga = ['light', 'moderate', 'vigorous'];
  int levelOlahragaIndex = 0;

  String jenisKelaminValue = 'female';
  String dateValueFix = 'Pilih Tanggal Lahir';
  String tingkatAktivitasValue = 'sedentary';
  String tipeDietValue = 'maintain';
  String levelOlahragaValue = 'light';
  bool veganValue = true;

  //objectbox material
  late Store userLogStore;
  var focusedDay = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);

  //-----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  //get method
  Future<void> getUserHealthPreferenceLatest() async {
    isLoadingUserHealthPreferenceLatest(true);
    await authController.getUsableToken();

    try {
      String accessToken = data.read('dataUser')['accessToken'];
      var _res = await _provider.getUserHealthPreferenceLatest(accessToken);

      if (_res.statusCode == 200) {
        UserHealthPreferenceLatestResponse _userHealthPreferenceLatestResponse =
            UserHealthPreferenceLatestResponse.fromJson(
                _res.body as Map<String, dynamic>);
        if (_userHealthPreferenceLatestResponse.statusCode == 200) {
          userHealthPreferenceLatestResponse.value =
              _userHealthPreferenceLatestResponse.data!;
        }
      }

      if (Get.isDialogOpen!) Get.back();
    } finally {
      isLoadingUserHealthPreferenceLatest(false);
    }
  }

  Future<void> getUserHealthHistoryLatest() async {
    isLoadingUserHealthHistoryLatest(true);
    await authController.getUsableToken();

    try {
      String accessToken = data.read('dataUser')['accessToken'];
      var _res = await _provider.getUserHealthHistoryLatest(accessToken);

      if (_res.statusCode == 200) {
        UserHealthHistoryLatestResponse _userHealthHistoryLatestResponse =
            UserHealthHistoryLatestResponse.fromJson(
                _res.body as Map<String, dynamic>);

        if (_userHealthHistoryLatestResponse.statusCode == 200) {
          userHealthHistoryLatestResponse.value =
              _userHealthHistoryLatestResponse.data!;
        }
      }

      if (Get.isDialogOpen!) Get.back();
    } finally {
      isLoadingUserHealthHistoryLatest(false);
    }
  }

  Future<void> getUserInformation() async {
    isLoadingUserInformation(true);
    await authController.getUsableToken();

    try {
      String accessToken = data.read('dataUser')['accessToken'];
      var _res = await _provider.getUserInformation(accessToken);

      if (_res.statusCode == 200) {
        UserInformationResponse _userInformationResponse =
            UserInformationResponse.fromJson(_res.body as Map<String, dynamic>);
        if (_userInformationResponse.statusCode == 200) {
          userInformationResponse.value = _userInformationResponse.data!;
        }
        print(userInformationResponse.value.displayName);
      }

      if (Get.isDialogOpen!) Get.back();
    } finally {
      isLoadingUserInformation(false);
    }
  }

  //post method
  Future<void> postUserHealthPreference(
      {UserHealthPreferenceRequest? postUserHealthPreferenceRequest}) async {
    if (postUserHealthPreferenceRequest!.activityLevel != null &&
        postUserHealthPreferenceRequest.sportDifficulty != null &&
        postUserHealthPreferenceRequest.vegan != null &&
        postUserHealthPreferenceRequest.vegetarian != null &&
        postUserHealthPreferenceRequest.halal != null) {
      await authController.getUsableToken();
      informationController
          .loadingDialog('Harap Menunggu, Sedang Memasukkan Data ke Server');
      try {
        String accessToken = data.read('dataUser')['accessToken'];
        final Response _res = await _provider.postUserHealthPreference(
            accessToken, postUserHealthPreferenceRequest);
        if (_res.statusCode == 200) {
          if (Get.isDialogOpen!) Get.back();
          informationController.showSuccessSnackBar('berhasil');
        } else {
          if (Get.isDialogOpen!) Get.back();
          informationController.showErrorSnackBar('gagal');
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
      informationController.snackBarError("Data Tidak Lengkap",
          "silakan isi semua data pribadi Anda terlebih dahulu");
    }
  }

  Future<void> postUserHealthHistory(
      {UserHealthHistoryRequest? userHealthHistoryRequest}) async {
    if (userHealthHistoryRequest!.height != null &&
        userHealthHistoryRequest.weight != null) {
      await authController.getUsableToken();
      informationController
          .loadingDialog('Harap Menunggu, Sedang Memasukkan Data ke Server');
      try {
        String accessToken = data.read('dataUser')['accessToken'];
        final Response _res = await _provider.postUserHealthHistory(
            accessToken, userHealthHistoryRequest);
        if (_res.statusCode == 200) {
          if (Get.isDialogOpen!) Get.back();
          informationController.showSuccessSnackBar('berhasil');
        } else {
          if (Get.isDialogOpen!) Get.back();
          informationController.showErrorSnackBar('gagal');
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
      informationController.snackBarError("Data Tidak Lengkap",
          "silakan isi semua data pribadi Anda terlebih dahulu");
    }
  }
}
