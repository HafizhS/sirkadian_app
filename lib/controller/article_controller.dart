import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sirkadian_app/model/article_model/article_all_response_model.dart';
import 'package:sirkadian_app/model/article_model/article_detail_response_model.dart';
import 'package:sirkadian_app/provider/article_provider.dart';
import 'auth_controller.dart';
import 'information_controller.dart';

class ArticleController extends GetxController {
  final _provider = Get.put(ArticleProvider());
  final authController = Get.put(AuthController());
  final informationController = Get.put(InformationController());
  final data = GetStorage('myData');

  RxList<DataArticleAllResponse> articleAll = <DataArticleAllResponse>[].obs;
  Rx<DataArticleDetailResponse> articleDetail = DataArticleDetailResponse().obs;
  var isLoadingArticleAll = false.obs;
  var isLoadingArticleDetail = false.obs;

//provider controller material
  Future<void> getArticleAll() async {
    isLoadingArticleAll(true);

    await authController.getUsableToken();

    try {
      String accessToken = data.read('dataUser')['accessToken'];
      var _res = await _provider.getArticleAll(accessToken);

      if (_res.statusCode == 200) {
        ArticleAllResponse _articleAllResponse =
            ArticleAllResponse.fromJson(_res.body as Map<String, dynamic>);
        if (_articleAllResponse.statusCode == 200) {
          articleAll.value = _articleAllResponse.data!;
        }
      }

      if (Get.isDialogOpen!) Get.back();
    } finally {
      isLoadingArticleAll(false);
    }
  }

  Future<void> getArticleDetail(int articleId) async {
    isLoadingArticleDetail(true);

    await authController.getUsableToken();

    try {
      String accessToken = data.read('dataUser')['accessToken'];
      var _res = await _provider.getArticleDetail(accessToken, articleId);
      print(_res.statusCode.toString() + 'dariArticleDetail');
      if (_res.statusCode == 200) {
        ArticleDetailResponse _articleDetailResponse =
            ArticleDetailResponse.fromJson(_res.body as Map<String, dynamic>);
        if (_articleDetailResponse.statusCode == 200) {
          articleDetail.value = _articleDetailResponse.data!;
        }
      }

      if (Get.isDialogOpen!) Get.back();
    } finally {
      isLoadingArticleDetail(false);
    }
  }
}
