import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sirkadian_app/model/subscription_model/subscription_active_user_model.dart';
import 'package:sirkadian_app/model/subscription_model/subscription_all_model.dart';
import 'package:sirkadian_app/provider/subscription_provider.dart';

import '../model/subscription_model/subscription_history_user_model.dart';
import 'auth_controller.dart';
import 'information_controller.dart';

class SubscriptionController extends GetxController {
  final authController = Get.put(AuthController());
  final _provider = Get.put(SubscriptionProvider());
  final informationController = Get.put(InformationController());
  // final data = GetStorage('myData');
  var isLoadingSubscriptionAll = false.obs;
  var isLoadingSubscriptionActiveUser = false.obs;
  var isLoadingSubscriptionHistoryUser = false.obs;
  var isLoadingIntegratedSubscriptionScreen = false.obs;

  final listSubscription = <DataSubscriptionAllResponse>[].obs;
  final listSubscriptionActiveUser = <DataSubscriptionActiveUserResponse>[].obs;
  final listSubscriptionHistoryUser =
      <DataSubscriptionHistoryUserResponse>[].obs;

  Future<void> getIntegratedSubscriptionScreen() async {
    isLoadingIntegratedSubscriptionScreen(true);
    await authController.getAccessToken().then((accessToken) async {
      try {
        // String accessToken = data.read('dataUser')['accessToken'];
        var _res = await _provider.getAllSubscription(accessToken);
        var _res2 = await _provider.getSubscriptionActiveUser(accessToken);
        var _res3 = await _provider.getSubscriptionHistoryUser(accessToken);

        if (_res.statusCode == 200 &&
            _res2.statusCode == 200 &&
            _res3.statusCode == 200) {
          SubscriptionAllResponse _subcriptionAllResponse =
              SubscriptionAllResponse.fromJson(
                  _res.body as Map<String, dynamic>);

          if (_subcriptionAllResponse.statusCode == 200) {
            listSubscription.value = _subcriptionAllResponse.data!;
          }

          SubscriptionActiveUserResponse _subscriptionActiveUser =
              SubscriptionActiveUserResponse.fromJson(
                  _res2.body as Map<String, dynamic>);

          if (_subscriptionActiveUser.statusCode == 200) {
            listSubscriptionActiveUser.value = _subscriptionActiveUser.data!;
          }
          SubscriptionHistoryUserResponse _subscriptionHistoryUser =
              SubscriptionHistoryUserResponse.fromJson(
                  _res3.body as Map<String, dynamic>);

          if (_subscriptionHistoryUser.statusCode == 200) {
            listSubscriptionHistoryUser.value = _subscriptionHistoryUser.data!;
          }
        }

        if (Get.isDialogOpen!) Get.back();
      } finally {
        isLoadingIntegratedSubscriptionScreen(false);
      }
    });
  }

  Future<void> getSubscriptionAll() async {
    isLoadingSubscriptionAll(true);
    await authController.getAccessToken().then((accessToken) async {
      try {
        // String accessToken = data.read('dataUser')['accessToken'];
        var _res = await _provider.getAllSubscription(accessToken);

        if (_res.statusCode == 200) {
          SubscriptionAllResponse _subcriptionAllResponse =
              SubscriptionAllResponse.fromJson(
                  _res.body as Map<String, dynamic>);

          if (_subcriptionAllResponse.statusCode == 200) {
            listSubscription.value = _subcriptionAllResponse.data!;
          }
        }

        if (Get.isDialogOpen!) Get.back();
      } finally {
        isLoadingSubscriptionAll(false);
      }
    });
  }

  Future<void> getSubscriptionActiveUser() async {
    isLoadingSubscriptionActiveUser(true);
    await authController.getAccessToken().then((accessToken) async {
      try {
        // String accessToken = data.read('dataUser')['accessToken'];
        var _res = await _provider.getSubscriptionActiveUser(accessToken);

        if (_res.statusCode == 200) {
          SubscriptionActiveUserResponse _subscriptionActiveUser =
              SubscriptionActiveUserResponse.fromJson(
                  _res.body as Map<String, dynamic>);

          if (_subscriptionActiveUser.statusCode == 200) {
            listSubscriptionActiveUser.value = _subscriptionActiveUser.data!;
          }
        }

        if (Get.isDialogOpen!) Get.back();
      } finally {
        isLoadingSubscriptionActiveUser(false);
      }
    });
  }

  Future<void> getSubscriptionHistoryUser() async {
    isLoadingSubscriptionHistoryUser(true);
    await authController.getAccessToken().then((accessToken) async {
      try {
        // String accessToken = data.read('dataUser')['accessToken'];
        var _res = await _provider.getSubscriptionHistoryUser(accessToken);

        if (_res.statusCode == 200) {
          SubscriptionHistoryUserResponse _subscriptionHistoryUser =
              SubscriptionHistoryUserResponse.fromJson(
                  _res.body as Map<String, dynamic>);

          if (_subscriptionHistoryUser.statusCode == 200) {
            listSubscriptionHistoryUser.value = _subscriptionHistoryUser.data!;
          }
        }

        if (Get.isDialogOpen!) Get.back();
      } finally {
        isLoadingSubscriptionHistoryUser(false);
      }
    });
  }

  //post method
  Future<void> postSubscriptionClaimCoupon({String? couponCode}) async {
    if (couponCode != '') {
      informationController
          .loadingDialog('Harap Menunggu, Sedang Memasukkan Data ke Server');
      await authController.getAccessToken().then((accessToken) async {
        try {
          // String accessToken = data.read('dataUser')['accessToken'];
          final Response _res = await _provider.postSubscriptionClaimCoupon(
              accessToken, couponCode);
          if (_res.statusCode == 200) {
            if (Get.isDialogOpen!) Get.back();
            informationController.showSuccessSnackBar('Claim coupon berhasil');
          } else {
            if (Get.isDialogOpen!) Get.back();
            informationController.showErrorSnackBar('Claim coupon gagal');
            print('error' + _res.statusCode.toString());
          }
        } catch (e) {
          e.toString();
          if (Get.isDialogOpen!) Get.back();
          informationController
              .showErrorSnackBar('terjadi masalah, harap ulangi');

          print(e);
        }
      });
    } else {
      if (Get.isDialogOpen!) Get.back();
      informationController.snackBarError("Data Tidak Lengkap",
          "silakan masukkan kode coupon Anda terlebih dahulu");
    }
  }
}
