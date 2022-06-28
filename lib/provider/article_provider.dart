import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sirkadian_app/model/url_model.dart';

class ArticleProvider extends GetConnect {
  final data = GetStorage('myData');
  //get method ----------------------------------------

  Future<Response> getArticleAll(accessToken) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${accessToken}'
    };
    _response =
        await get('${articleAllGetUrl}page=1&per_page=10', headers: headers);

    return _response;
  }

  Future<Response> getArticleDetail(accessToken, articleId) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${accessToken}'
    };

    _response = await get('${articleDetailGetUrl}$articleId', headers: headers);

    return _response;
  }
}
