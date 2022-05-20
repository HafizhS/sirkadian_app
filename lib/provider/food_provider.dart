import 'package:get/get_connect.dart';
import 'package:sirkadian_app/model/url_model.dart';

class FoodProvider extends GetConnect {
  //post method------------------------------------------------------

  //get method-------------------------------------------------------

  Future<Response> getFoodRecommendation(
      String accessToken, String session, int page) async {
    Response? _response;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    print('${foodRecommendationGetUrl}food_time=${session}&page=$page');
    _response = await get(
        '${foodRecommendationGetUrl}food_time=${session}&page=$page',
        headers: headers);

    return _response;
  }

  Future<Response> getNecessity(accessToken) async {
    Response? _response;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    _response = await get(necessityGetUrl, headers: headers);

    return _response;
  }
}
