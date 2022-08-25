import 'package:get/get_connect.dart';
import 'package:sirkadian_app/model/food_model/food_history_request_model.dart';
import 'package:sirkadian_app/model/url_model.dart';

class FoodProvider extends GetConnect {
  //post method------------------------------------------------------

  //get method-------------------------------------------------------
  Future<Response> getFoodAll(String accessToken) async {
    Response? _response;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    _response = await get(foodAllGetUrl, headers: headers);

    return _response;
  }

  Future<Response> getFoodRecommendation(
      String accessToken, String session, int page, String foodEaten) async {
    Response? _response;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    _response = await get(
        '${foodRecommendationGetUrl}food_time=${session}&page=$page$foodEaten',
        headers: headers);

    return _response;
  }

  Future<Response> getFoodRecommendationByFood(String accessToken,
      String session, String foodId, String foodEaten) async {
    Response? _response;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    print(
        '${foodRecommendationByFoodGetUrl}$foodId/recommendation_by_food?food_time=${session}${foodEaten}');
    _response = await get(
        '${foodRecommendationByFoodGetUrl}$foodId/recommendation_by_food?food_time=${session}${foodEaten}',
        headers: headers);

    return _response;
  }

  Future<Response> getFoodRecommendationMenu(String accessToken, String session,
      int page, String foodEaten, String foodType) async {
    Response? _response;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    print(
        '${foodRecommendationMenuGetUrl}food_time=${session}&page=$page$foodEaten$foodType');
    _response = await get(
        '${foodRecommendationMenuGetUrl}food_time=${session}&page=$page$foodEaten$foodType',
        headers: headers);

    return _response;
  }

  Future<Response> getFoodItem(accessToken, id) async {
    Response? _response;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    _response = await get('$foodItemGetUrl/$id', headers: headers);

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

  Future<Response> getOtherFoodRecommendation(
      accessToken, foodId, session) async {
    Response? _response;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    _response = await get(
        '$rootUserFood/$foodId/recommendation_by_food?food_time=$session',
        headers: headers);

    return _response;
  }

  Future<Response> getFoodHistory(
      {String? accessToken, String? startDate, String? endDate}) async {
    Response? _response;
//2022-03-21
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    _response = await get(
        '$foodHistoryGetPostUrl?end_date=$endDate&start_date=$startDate',
        headers: headers);

    return _response;
  }

  //post method
  Future<Response> postFoodHistory(
      accessToken, FoodHistoryRequest foodHistoryRequest) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${accessToken}'
    };
    _response = await post(foodHistoryGetPostUrl, foodHistoryRequest.toJson(),
        headers: headers);
    print(foodHistoryRequest.toJson());

    return _response;
  }
}
