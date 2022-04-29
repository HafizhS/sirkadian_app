import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sirkadian_app/model/subscription_model/subscription_all_model.dart';
import 'package:sirkadian_app/provider/subscription_provider.dart';

import 'auth_controller.dart';

class SubscriptionController extends GetxController {
  final authController = Get.put(AuthController());
  final _provider = Get.put(SubscriptionProvider());
  final data = GetStorage('myData');
  final isLoadingSubscriptionAll = false.obs;

  final listSubscription = <DataSubscriptionAllResponse>[].obs;
  Future<void> getSubscriptionAll() async {
    isLoadingSubscriptionAll(true);
    await authController.getUsableToken();
    try {
      String accessToken = data.read('dataUser')['accessToken'];
      var _res = await _provider.getAllSubscription(accessToken);

      if (_res.statusCode == 200) {
        SubscriptionAllResponse _subcriptionAllResponse =
            SubscriptionAllResponse.fromJson(_res.body as Map<String, dynamic>);

        if (_subcriptionAllResponse.statusCode == 200) {
          listSubscription.value = _subcriptionAllResponse.data!;
        }
      }

      if (Get.isDialogOpen!) Get.back();
    } finally {
      isLoadingSubscriptionAll(false);
    }
  }
}
