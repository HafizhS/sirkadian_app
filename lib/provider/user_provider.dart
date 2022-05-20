import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sirkadian_app/model/url_model.dart';

class UserProvider extends GetConnect {
  final data = GetStorage('myData');
  //get method ----------------------------------------

  Future<Response> getUserHealthPreferenceLatest(accessToken) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${accessToken}'
    };
    _response = await get(userHealthPreferenceLatestGetUrl, headers: headers);

    return _response;
  }

  Future<Response> getUserHealthHistoryLatest(accessToken) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${accessToken}'
    };
    _response = await get(userHealthHistoryLatestUrl, headers: headers);

    return _response;
  }

  Future<Response> getUserInformation(accessToken) async {
    Response? _response;

    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${accessToken}'
    };
    _response = await get(userInfromationGetUrl, headers: headers);

    return _response;
  }
}
