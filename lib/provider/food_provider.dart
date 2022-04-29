import 'package:get/get_connect.dart';
import 'package:sirkadian_app/model/url_model.dart';

class FoodProvider extends GetConnect {
  //post method------------------------------------------------------

  //get method-------------------------------------------------------

  Future<Response> getAllFood(accessToken) async {
    Response? _response;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    _response = await get(foodAllGetUrl, headers: headers);

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
