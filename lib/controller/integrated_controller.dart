import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sirkadian_app/controller/article_controller.dart';
import 'package:sirkadian_app/controller/food_controller.dart';
import 'package:sirkadian_app/controller/user_controller.dart';
import 'package:sirkadian_app/provider/article_provider.dart';
import 'package:sirkadian_app/provider/food_provider.dart';

import '../model/article_model/article_all_response_model.dart';
import '../model/food_model/necessity_response_model.dart';
import '../model/user_model/user_health_historyLatest_response_model.dart';
import '../model/user_model/user_information_response_model.dart';
import '../provider/user_provider.dart';
import 'auth_controller.dart';

class IntegratedController extends GetxController {
  final authController = Get.put(AuthController());
  final userController = Get.put(UserController());
  final foodController = Get.put(FoodController());
  final articleController = Get.put(ArticleController());
  final _userProvider = Get.put(UserProvider());
  final _foodProvider = Get.put(FoodProvider());
  final _articleProvider = Get.put(ArticleProvider());
  final data = GetStorage('myData');
  var isLoadingHomeRequestApi = false.obs;
  //home
  Future<void> homeRequestApi() async {
    isLoadingHomeRequestApi(true);
    await authController.getAccessToken().then((accessToken) async {
      try {
        // String accessToken = data.read('dataUser')['accessToken'];
        var _res = await _userProvider.getUserHealthHistoryLatest(accessToken);
        var _res2 = await _userProvider.getUserInformation(accessToken);
        var _res3 = await _foodProvider.getNecessity(accessToken);
        var _res4 = await _articleProvider.getArticleAll(accessToken);
        if (_res.statusCode == 200 &&
            _res2.statusCode == 200 &&
            _res3.statusCode == 200 &&
            _res4.statusCode == 200) {
          UserHealthHistoryLatestResponse _userHealthHistoryLatestResponse =
              UserHealthHistoryLatestResponse.fromJson(
                  _res.body as Map<String, dynamic>);

          if (_userHealthHistoryLatestResponse.statusCode == 200) {
            userController.userHealthHistoryLatestResponse.value =
                _userHealthHistoryLatestResponse.data!;
          }

          UserInformationResponse _userInformationResponse =
              UserInformationResponse.fromJson(
                  _res2.body as Map<String, dynamic>);
          if (_userInformationResponse.statusCode == 200) {
            userController.userInformationResponse.value =
                _userInformationResponse.data!;
          }

          NecessityResponse _necessityResponse =
              NecessityResponse.fromJson(_res3.body as Map<String, dynamic>);

          if (_necessityResponse.statusCode == 200) {
            foodController.necessity.value = _necessityResponse.data!;
          }

          ArticleAllResponse _articleAllResponse =
              ArticleAllResponse.fromJson(_res4.body as Map<String, dynamic>);
          if (_articleAllResponse.statusCode == 200) {
            articleController.articleAll.value = _articleAllResponse.data!;
          }
        }

        if (Get.isDialogOpen!) Get.back();
      } finally {
        isLoadingHomeRequestApi(false);
      }
    });
  }
}
